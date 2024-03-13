use config::{Config, ConfigError, Environment, File};
use std::env;
use std::collections::HashMap;

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
pub struct DownQuark {
  application: String,
  root_directory:Vec<String>,
  repository:ApplicationRepo,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
struct RepositoryConfig {
  pub url: String,
  pub semver_key: String,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
struct ApplicationRepo {
  main: String,
  pub conf:RepositoryConfig,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
struct DevQonDirectory {
  application: Vec<String>,
  home: Vec<String>,
  resource: Vec<String>,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
pub struct DevQonParsedDirectory {
  application: String,
  pub home: String,
  resource: String,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
struct DevQonLogging {
  level: String,
  output: Vec<String>,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
pub struct DevQon {
  auto_update: bool,
  debug: bool,
  directory: DevQonDirectory,
  pub directory_parsed: DevQonParsedDirectory,
  logging: DevQonLogging,
  repository:ApplicationRepo,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
struct Database {
  id: String,
  url: String,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
struct ToDo {
  database:Vec<Database>,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
pub struct DevQonConfig {
  pub _dq:DownQuark,
  pub devqon:DevQon,
  todo:ToDo,
}

impl DevQonConfig {
  pub fn make_config(sys_conf_paths:HashMap<&str, String>) -> Result<Self, ConfigError> {
    let config_directory = sys_conf_paths["APPLICATION"].to_owned()+"/devqon/src-tauri/config/"; // concat full application path with config dir path
    let run_env = env::var("RUN_ENV").unwrap_or_else(|_| "development".into()); // Default to 'development' env
    let devqon_conf = Config::builder() // as sources are added below duplicate keys will overwrite previously defined values
        .add_source(File::with_name(&(config_directory.clone()+"_default"))) // default configuration file
        .add_source(File::with_name(&(config_directory.clone()+&format!("{}", run_env))) // file with env overrides - defaulted to 'development' above
            .required(false),) // optional file - does not throw if file DNE
        .add_source( // optional local configuration file - ensure locality by omitting from repository
          File::with_name(&(config_directory.clone()+"local")).required(false))
          // below applies cli variables specified by given prefix
        .add_source(Environment::with_prefix("dq")) // `DQ_DEBUG=1 ./target/app` would set the `debug` key to true
        .add_source(Environment::with_prefix("devqon")) // `DEVQON_DEBUG=0 DQ_DEBUG=1 ./target/app` would immediately overwrite the `debug` key to be false
        .set_override("devqon.directory_parsed.home", sys_conf_paths["HOME"].to_string())? // programmatically change settings after parsing the `sys_conf_paths`
        .set_override("devqon.directory_parsed.application", sys_conf_paths["APPLICATION"].to_string())?
        .set_override("devqon.directory_parsed.resource", sys_conf_paths["RESOURCE"].to_string())?
        .build()?;

    // deserialize, freeze, and return configuration
    devqon_conf.try_deserialize()
  }
  pub fn get_remote_validation_paths(&self) -> HashMap<String, Vec<String>> {
    HashMap::from([
      ("_DQ".to_string(), vec![self._dq.repository.conf.url.to_string(),self._dq.repository.conf.semver_key.to_string()]),
      ("DEVQON".to_string(), vec![self.devqon.repository.conf.url.to_string(),self.devqon.repository.conf.semver_key.to_string()]),
    ])
  }
  pub fn get_validation_paths(home_dir:String) -> HashMap<String, Vec<String>> {
    HashMap::from([
      ("_DQ".to_string(), vec![home_dir.clone(),".dq".to_string(),"_dq".to_string()]),
      ("DEVQON".to_string(), vec![home_dir.clone(),".dq".to_string(),"devqon".to_string(),"_devqon".to_string()]),
    ])
  }
}
