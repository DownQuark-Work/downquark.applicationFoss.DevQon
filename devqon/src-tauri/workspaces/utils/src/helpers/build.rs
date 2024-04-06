use tauri::Manager;

use crate::configuration::DevQonConfig;
use crate::constants::enumerate;
use crate::helpers::{
  tray as dq_tray,
  state as dq_state
};

// use persistence::database;
// use crate::hooks::traits as dq_hooks;

mod http;
mod initialize;
mod paths;

pub fn initialize_application(tray_handle: &tauri::AppHandle){
  let main_window = tray_handle.get_webview_window(&enumerate::EnumAppElement::WindowMain.get_id()).unwrap();
  let splashscreen_window = tray_handle.get_webview_window(&enumerate::EnumAppElement::WindowSplashScreen.get_id()).unwrap();
  let tray_sys = tray_handle.tray_by_id(&enumerate::EnumAppElement::TrayMenuAndIcon.get_id()).unwrap();

  dq_tray::handle_system_tray_icon_update(tray_handle.clone(),enumerate::EnumIconStatusType::BUSY); // set icon to downquark logo
  #[cfg(target_os = "macos")] // only supported on macos - only run on macos
  let _ = tray_sys.set_icon_as_template(true);

  tauri::async_runtime::spawn(async move { // run initialization code on new task so app doesn't freeze
    let sys_paths = paths::get_sys_paths(tray_sys.app_handle());
    // println!("build.rs > sys_paths: {:?}",sys_paths);
    dq_state::configuration::set_app_configuration(sys_paths.clone(),tray_sys.app_handle());
    let dq_config_state = tray_sys.app_handle().state::<DevQonConfig>();
    
    // TODO: Would it help below if initial database query happened here?
    let on_app_launch_conf:initialize::OnAppLaunchStruct
          = initialize::configure_app_launch_config(dq_config_state.inner()).await;

    println!("on_app_launch_conf: {:?}",on_app_launch_conf.get_app_launch_conf());
    println!("START HERE!");
    println!("START HERE!");
    println!("https://docs.rs/sqlx/latest/sqlx/");
    println!("https://docs.rs/sqlx/latest/sqlx/fn.raw_sql.html:");
    println!("https://docs.rs/sqlx/latest/sqlx/types/uuid/index.html: Use version 7");
    println!("https://docs.rs/sqlx/latest/sqlx/struct.QueryBuilder.html");
    println!("THEN");
    println!("https://docs.rs/arangors/latest/arangors/");
    println!("START HERE!");
    println!("START HERE!");
    println!("START HERE!");
    println!("stub the views and load them (with the prompt to update?) at this point ... move it into another method call outside of the main build path though");

    /* STUBBED with ZERO CONNECTION DATA
    let db_instance = persistence::config_persistent(&persistence::EnumPersistenceTypes::DatabaseMaria);
    let mut requested_data = persistence::request_persistent_data(&db_instance,"A");
    println!("requested_data: {requested_data:?}");
    requested_data = persistence::request_persistent_data(&db_instance,"Z");
    // https://newsletter.techworld-with-milan.com/i/141230389/factory-method
    println!("requested_data: {requested_data:?}");
    */

    println!("");
//   pub async fn on_application_startup_query(dq_conf:&DevQonConfig) -> String {
//   let db_instance = config_persistent(&EnumPersistenceTypes::DatabaseMaria);
//     let db_maria_config = dq_conf.get_db_connection_config(db_instance);
//     for (table_ref, connection_str) in db_maria_config.iter() {
//       println!("table_ref: {table_ref:?}");
//       println!("connection_str: {connection_str:?}");
//     };
//     println!("db_maria_config: {:?}",db_maria_config[&0]);
//   "Database Startup Data".to_string()
// }


// let db_instance = persistence::config_persistent(&persistence::EnumPersistenceTypes::DatabaseMaria);
//     let mut requested_data = persistence::request_persistent_data(&db_instance,"A");
//     println!("requested_data: {requested_data:?}");
//     requested_data = persistence::request_persistent_data(&db_instance,"Z");
//     // https://newsletter.techworld-with-milan.com/i/141230389/factory-method
//     println!("requested_data: {requested_data:?}");
//     println!("");
//     println!("dq_config_state: {:?}",dq_config_state.get_db_connection_config(db_instance));

    // let db_instance = persistence::config_persistent(&persistence::EnumPersistenceTypes::DatabaseMaria);
    let db_config = dq_config_state.get_db_connection_config(&persistence::EnumPersistenceTypes::DatabaseMaria);
    println!("db_config: {db_config:?}");
    let db_startup_data:String = persistence::on_application_startup_query(db_config).await;
    println!("db_startup_data: {db_startup_data:?}");
    println!("");
    
    // After it's done, close the splashscreen and display the main window
    // MAYBE THIS:: https://docs.rs/tauri/2.0.0-beta.11/tauri/trait.Manager.html#method.listen_any
    // println!("initial_page: {initial_page:?}");
    let _ = splashscreen_window.destroy(); // should only be needed once
    main_window.show().unwrap();
    dq_tray::handle_system_tray_icon_update(tray_sys.app_handle().clone(),enumerate::EnumIconStatusType::_DQ); // set icon to downquark logo

    // trigger a hook here instead
    // dq_hooks::traits();
    // enhancements::mechanisms::database::configure_mechanism_db()
  });
  // let _ = http::block_get_request(); // blocking must be outside of async thread above
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