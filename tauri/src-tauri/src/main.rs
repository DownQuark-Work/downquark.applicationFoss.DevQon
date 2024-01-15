// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]
use tauri::Manager;
use utils::helpers::{commands, state};


fn main() {
  tauri::Builder::default()
    .system_tray(utils::helpers::system_tray::create_system_tray())
      .on_system_tray_event(|app, event| { utils::helpers::system_tray::handle_system_tray_events(app.clone(), event) })
    .setup(|app| {
      #[cfg(debug_assertions)] // only include this code on debug builds
      { app.get_window("main").unwrap().open_devtools(); }
      utils::helpers::build::handle_tauri_setup(app); Ok(())
    })
    .on_window_event(|event| { utils::helpers::build::run_frontend_in_background(event) })
    .manage(state::_devqon::set_user_session()) // set initial static state - make sure values are populated
    .manage(state::_devqon::ActiveVision{ current_vision: Default::default() }) // set initial mutable state with default values - we can mutate
    .manage(state::_devqon::History{ navigation: Default::default() }) // set initial mutable state with default values - we can mutate
    .manage(commands::_devqon::Database::default())
    .invoke_handler(tauri::generate_handler![ // call methods to update state _after_ they've been registered
      commands::_devqon::cmd_two_way_comm,
      commands::_devqon::cmd_connect_to_database,
      commands::_devqon::cmd_determine_view_and_title,
      commands::_devqon::cmd_state_trigger_us,
      commands::_devqon::update_current_vision_setting,
      commands::_devqon::track_navigation,
    ])
    .run(tauri::generate_context!())
    .expect("error while running tauri application");
}