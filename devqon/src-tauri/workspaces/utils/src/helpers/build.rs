use tauri::Manager;

use crate::configuration::DevQonConfig;
use crate::constants::enumerate::{self, EnumStateAppView};
use crate::helpers::{
  tray as dq_tray,
  state as dq_state
};

use crate::helpers::state::_devqon::UserSession;

// use persistence::database;
// use crate::hooks::traits as dq_hooks;

mod http;
mod initialize;
mod paths;

// the payload type must implement `Serialize` and `Clone`.
#[derive(Clone, Debug, serde::Serialize)]
struct EmitPayloadApplicationInitialization {
  init_view:String,
  session_exists:bool,
  update_available:bool,
  usr_uuid:String,
}

#[derive(Clone, serde::Serialize)]
struct Payload {
  message: String,
}

pub fn initialize_application(app_handle: &tauri::AppHandle){
  let tray_sys = app_handle.tray_by_id(&enumerate::EnumAppElement::TrayMenuAndIcon.get_id()).unwrap();

  dq_tray::handle_system_tray_icon_update(app_handle.clone(),enumerate::EnumIconStatusType::BUSY); // set icon to downquark logo
  #[cfg(target_os = "macos")] // only supported on macos - only run on macos
  let _ = tray_sys.set_icon_as_template(true);

  tauri::async_runtime::spawn(async move { // run initialization code on new task so app doesn't freeze
    let sys_paths = paths::get_sys_paths(tray_sys.app_handle());
    dq_state::configuration::set_app_configuration(sys_paths.clone(),tray_sys.app_handle());
    let dq_config_state = tray_sys.app_handle().state::<DevQonConfig>();
    
    // gets conf values saved to local machine [including user_id if exists]
      // use these values to determine authenticated landing page to display and if version update is required
    let on_app_launch_conf:initialize::OnAppLaunchStruct
          = initialize::configure_app_launch_config(dq_config_state.inner()).await;
    let usr_status = on_app_launch_conf.get_stored_usr_info(); // (db_usr_lookup:String, db_last_session:String)
    let mut validated_usr_status = (false,""); // (previous_session_exists,usr_full_uuid_returned_from_db_usr_lookup)
    
    // if user_id exists from above. verify the id exists in the db and retrieve full user information
      // use these values to determine if user is required to login/sign-up
    let db_config = dq_config_state.get_db_connection_config(&persistence::EnumPersistenceTypes::DatabaseMaria);
    persistence::on_application_startup_query(db_config).await;
    // TODO: Make actual database calls here
    if usr_status.0.len() > 2 { // user has previously registered and has an existing lookup id, continue user login session
      println!("DATABASE Query for user lookup: {:?}", (String::from(usr_status.1)));
        // TEMP: assume successful db qry
          // set `validated_usr_status` to mapped uuid value from `QrxAggregate` database
      validated_usr_status.1 = "63a03700-f18d-11ee-96c2-c29d42d3cfc8";
      
      if validated_usr_status.1.len() >= 2 { // successfully found user uuid
        /*
          run another query to retrieve last login time for `_devqon`
          - if within 30 days set session key to true for validated_usr_status.0
            - no login required
          - if DNE or outside of that range require another login
        */ 
        println!("DATABASE Query for valid active session: {:?}", usr_status.0);
        // for now: stub existing session - lookup db qry successful
        validated_usr_status.0 = true;
      }
    }

    println!("Prompt register/login if needed:");

    let mut conf_app_launch = on_app_launch_conf.get_app_launch_conf();
    println!("on_app_launch_conf (init_view:EnumStateAppView, version_update_available:bool): {:?}",conf_app_launch);
    println!("stub the views and load them (with the prompt to update?) at this point ... move it into another method call outside of the main build path though");
    println!("Tauri STATE: {:?}",tray_sys.app_handle().state::<UserSession>());

    // override conf_app_launch if user DNE
    if validated_usr_status.1.len() == 0 { // no lookup key found - register prompt
      println!("NO USER FOUND - USER MUST SIGN-IN/REGISTER: {validated_usr_status:?}");
      conf_app_launch.0 = &EnumStateAppView::SplashScreen;
    } else {
      if !validated_usr_status.0 { // lookup found, cert may have expired
        println!("USER MUST REAUTHENTICATE: {validated_usr_status:?}");
        conf_app_launch.0 = &EnumStateAppView::SplashScreen;
      }
    }
    
    dq_tray::handle_system_tray_icon_update(tray_sys.app_handle().clone(),enumerate::EnumIconStatusType::_DQ); // set icon to downquark logo
    
    // emit here
    let emit_payload = EmitPayloadApplicationInitialization{ 
      init_view:String::from(conf_app_launch.0.to_payload()),
      update_available:conf_app_launch.1,
      session_exists:validated_usr_status.0,
      usr_uuid:String::from(validated_usr_status.1),
    };
    // println!("emit_payload: {emit_payload:?}");
    let _ = tray_sys.app_handle().emit("on-validations-complete", emit_payload);
  });
  // let _ = http::block_get_request(); // blocking must be outside of async thread above
}

pub fn handle_authorization_state(app_handle: &tauri::AppHandle) { // called from commands
  // a lot of handwaving here assuming authorization handling will be more intense (and vary) per actual application integration
    // TEMP: "63a03700-f18d-11ee-96c2-c29d42d3cfc8" mapped uuid value from `QrxAggregate` database
    println!("UPDATED? Tauri STATE: {:?}", app_handle.state::<UserSession>()); 
    
    let main_window = app_handle.get_webview_window(&enumerate::EnumAppElement::WindowMain.get_id()).unwrap();
    let splashscreen_window = app_handle.get_webview_window(&enumerate::EnumAppElement::WindowSplashScreen.get_id()).unwrap();

    let _ = splashscreen_window.destroy(); // should only be needed once
    // DO NOT run the rest of the code until the user is registered and logged in
    main_window.show().unwrap();

    // println!("DEBUG SLEEP...");
    // std::thread::sleep(std::time::Duration::from_secs(2));
    // println!("Done DEBUG SLEEP.");
    // // emit here
    // let _ = tray_sys.app_handle().emit("on-validations-complete", 99);
}

pub fn run_backend_in_background(event:tauri::RunEvent) {
  match event {
    tauri::RunEvent::ExitRequested { api, .. } => { api.prevent_exit(); }
    _ => {}
  }
}

pub fn run_frontend_in_background(win:&tauri::Window,event:tauri::WindowEvent) {
  match event { 
      tauri::WindowEvent::CloseRequested { api, .. } => {
        let _ = &win.hide().unwrap(); // need to see this fail to make it work
        api.prevent_close();
      }
      _ => {}
    }
}