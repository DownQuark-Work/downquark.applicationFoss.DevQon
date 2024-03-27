use crate::configuration::DevQonConfig;
use crate::constants::enumerate::EnumStateAppView;

mod initialize {
  use std::collections::HashMap;
  use toml::{Value};

  use crate::configuration::DevQonConfig;
  use crate::helpers::{
    build::{http, initialize::validate, paths, },
    standards::fsio,
  };

  pub fn get_conf_file_paths(dq_conf:&DevQonConfig) -> HashMap<String, HashMap<String, Vec<String>>> {
    let local_validation_paths = DevQonConfig::get_validation_paths(dq_conf.devqon.directory_parsed.home.to_string());
    let remote_validation_paths = dq_conf.get_remote_validation_paths();
    HashMap::from([
      ("LOCAL_VALIDATION".to_string(), local_validation_paths),
      ("REMOTE_VALIDATION".to_string(), remote_validation_paths),
    ])
  }

  pub fn determine_init_page_to_view(paths_to_validate:Vec<String>) -> u8 { // has the user installed this app or any other by dq?
    let mut total_validation_successes = 0;
    for validating_path in paths_to_validate.iter() {
      let validation_successes = validate::is_valid_path(validating_path);
      total_validation_successes += validation_successes;
    }
  
    if total_validation_successes >= 4 { // devqon config file was located
      fsio::parse_file_as_toml(&paths_to_validate[1]);
      total_validation_successes += validate::config_contains_valid_vision(&paths_to_validate[1]);
    }
    total_validation_successes
  }
  
  pub fn get_local_app_versions(current_config_files:HashMap<String, Vec<String>>) -> HashMap<String,Vec<String>> {
    let mut local_app_versions = HashMap::new();
    for (application, config_file) in current_config_files.iter() {
      let config_file_version = validate::get_version_in_conf_file(&config_file.join("/"));
      local_app_versions.insert(application.to_string(),vec![config_file_version,config_file.join("/").to_string()]);
    }
    local_app_versions
  }

  pub async fn get_remote_app_versions(remote_request_information:HashMap<String, Vec<String>>) -> HashMap<String,String> {
    let mut remote_app_versions = HashMap::new();
    for (application, remote_request) in remote_request_information.iter() {
      let remote_req = &remote_request[0];
      let current_remote_version = http::await_get_request(remote_req).await;
      let current_remote_version_toml = fsio::parse_content_as_toml(current_remote_version.expect("Invalid Url Response"));
      let toml_version_path = remote_request[1].split(".");
      let toml_version_path_collection = toml_version_path.collect::<Vec<_>>();
      
      let mut cur_walked_toml_path_value:Option<&Value> = current_remote_version_toml.get(toml_version_path_collection[0]);
      for path_key in toml_version_path_collection.iter() {
        if path_key.to_string() != toml_version_path_collection[0].to_string() {
          if path_key.to_string() == "0".to_string()
            { cur_walked_toml_path_value = cur_walked_toml_path_value.expect("invalid path key").get(0); }
          else
            { cur_walked_toml_path_value = cur_walked_toml_path_value.expect("invalid path key").get(path_key); }
        }
      }
      remote_app_versions.insert(application.to_string(),cur_walked_toml_path_value.expect("Invalid version").to_string());
    }
    remote_app_versions
  }

  pub fn check_for_version_update(local_versions:HashMap<String,Vec<String>>,remote_versions:HashMap<String,String>) -> bool {
    let mut update_needed = false;
    for (application, remote_version) in remote_versions.iter() {
      // If first load then update to most recent production version
      let mut version_auto_update = false;
      if local_versions[application][0] == "\"0.0.0\"" { // first load after auto-generation
        paths::update_application_version(
            &local_versions[application][1],
            &local_versions[application][0].replace("\"", ""),
            &remote_version.replace("\"", ""),
        );
        version_auto_update = true;
      }
      
      // Assuming that release versions will be semver only.
      // Any hyphen would be releated with a release candidate, apha, beta, etc
      // - ignore if found, and accept the stored version as correct
      if !version_auto_update && !remote_version.contains("-") {
        let local_semver_bind = local_versions[application][0].replace("\"", "");
        let local_semver = local_semver_bind.split(".").collect::<Vec<_>>();
        let remote_semver_bind = remote_version.replace("\"", "");
        let remote_semver = remote_semver_bind.split(".").collect::<Vec<_>>();
  
        for (i,rem_semver) in remote_semver.iter().enumerate() {
          let rem_semver_parsed = rem_semver.parse::<u8>();
          let loc_semver_parsed = local_semver[i].parse::<u8>();
          if rem_semver_parsed.unwrap() > loc_semver_parsed.unwrap() { update_needed = true; }
        }
      }
    }
    update_needed
  }
}

mod validate { // user file system access should not have pub access
  use std::path::Path;
  use crate::constants::enumerate::EnumStateAppView;
  use crate::helpers::{build::{initialize::OnAppLaunchStruct, paths, },
                            standards::fsio};
  
  // user file system access should not have pub access
  fn determine_landing_page(validation_amount:u8) -> EnumStateAppView {
    let active_landing_page = match validation_amount {
      1 => EnumStateAppView::LandingInitDq,
      2|3 => EnumStateAppView::LandingInitDevqon,
      4|5 => EnumStateAppView::LandingNoActiveVision,
      6 => EnumStateAppView::LandingActiveVision,
      _ => EnumStateAppView::LandingInitDq,
    };
    active_landing_page
  }

  pub fn is_valid_path(path_str:&str) -> u8 {
    let mut validated_steps = 0;
    let file_path = Path::new(path_str);
    let path_exists = file_path.try_exists().expect("path DNE");
    if path_exists { 
      validated_steps += 1;
      if file_path.is_file() { validated_steps += 1; }
    } else {
      paths::create_config_file(file_path);
      println!("FILE DNE");
    }
    validated_steps
  }

  pub fn config_contains_valid_vision(path_str:&str) -> u8 {
    // println!("config_contents_bind: {config_contents_bind:?}");
    let toml_parse = fsio::parse_file_as_toml(path_str);
    let mut additional_validations = 0;
    let current_directory = Path::new(path_str).parent().expect("directory DNE");
    let vision_toml_file_val = &toml_parse["devqon"]["vision"][0]["conf_toml"];
    let binding = vision_toml_file_val.as_str().expect("invalid file");
    let vision_toml_file = Path::new(current_directory).join(binding);
    if binding != "invalid file" { additional_validations += 1; }
    if vision_toml_file_val.as_str() != Some("") {
      let vision_toml_file_exists = vision_toml_file.try_exists().expect("path DNE");
      if vision_toml_file_exists { additional_validations += 1; }
    }

    additional_validations
  }

  pub fn get_version_in_conf_file(file_path:&str) -> String {
    let toml_parse = fsio::parse_file_as_toml(file_path);
    let vision_toml_file_val;
    if file_path.contains("_devqon") { // TODO: unharcode this
      vision_toml_file_val = &toml_parse["devqon"]["version"];
    } else { vision_toml_file_val = &toml_parse["DownQuark"]["version"]; }
    vision_toml_file_val.to_string()
  }

  pub fn pre_app_launch(validation_amt:u8,new_version_available:bool) -> OnAppLaunchStruct {
    let page_in_queue = determine_landing_page(validation_amt);
    // page_in_queue // after TODO3 this should return the correct enum value from the `hooks` to update the page to the correct location
    OnAppLaunchStruct {
      init_view:page_in_queue,
      version_update_available:new_version_available,
    }
  }
}

pub struct OnAppLaunchStruct {
  init_view:EnumStateAppView,
  version_update_available:bool,
}
impl OnAppLaunchStruct {
  pub fn get_app_launch_conf(&self) -> (&EnumStateAppView, bool) {
    (&self.init_view,self.version_update_available)
  }
}

pub async fn configure_app_launch_config(dq_conf:&DevQonConfig) -> OnAppLaunchStruct {
  let dq_config_file_paths = initialize::get_conf_file_paths(dq_conf);
  let local_config_file_paths = vec![ dq_config_file_paths["LOCAL_VALIDATION"]["_DQ"].join("/"), dq_config_file_paths["LOCAL_VALIDATION"]["DEVQON"].join("/") ];
  let init_page_to_view = initialize::determine_init_page_to_view(local_config_file_paths);
  let local_config_information = &dq_config_file_paths["LOCAL_VALIDATION"];
  let local_app_versions = initialize::get_local_app_versions(local_config_information.clone());
  let remote_config_information = &dq_config_file_paths["REMOTE_VALIDATION"];
  let remote_app_versions = initialize::get_remote_app_versions(remote_config_information.clone()).await;
  let new_version_available = initialize::check_for_version_update(local_app_versions,remote_app_versions);
  
  validate::pre_app_launch(init_page_to_view,new_version_available)
}