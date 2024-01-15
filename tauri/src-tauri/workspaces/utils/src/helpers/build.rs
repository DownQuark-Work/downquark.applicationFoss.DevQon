use tauri::Manager;

use crate::constants::enumerate;
use crate::helpers::system_tray;

pub fn handle_tauri_setup(app:&mut tauri::App) {
  let app_handle = app.handle();
  system_tray::handle_system_tray_icon_update(app_handle.clone(),enumerate::EnumIconStatusType::BUSY); // set icon to loading symbol

  let splashscreen_window = app.get_window("splashscreen").unwrap();
  let main_window = app.get_window("main").unwrap();
  tauri::async_runtime::spawn(async move { // run initialization code on new task so app doesn't freeze
    
    println!("Initializing...");
    println!("Initialize app here instead of sleeping");
    std::thread::sleep(std::time::Duration::from_secs(3)); // replace sleep w/ actual code
    println!("Initialized");

    // After it's done, close the splashscreen and display the main window
    splashscreen_window.close().unwrap();
    main_window.show().unwrap();
    system_tray::handle_system_tray_icon_update(app_handle,enumerate::EnumIconStatusType::_DQ); // set icon to downquark logo
  });
}

pub fn run_backend_in_background(event:tauri::RunEvent) {
  match event {
    tauri::RunEvent::ExitRequested { api, .. } => { api.prevent_exit(); }
    _ => {}
  }
}

pub fn run_frontend_in_background(event:tauri::GlobalWindowEvent) {
  match event.event() { 
      tauri::WindowEvent::CloseRequested { api, .. } => {
        event.window().hide().unwrap();
        api.prevent_close();
      }
      _ => {}
    }
}