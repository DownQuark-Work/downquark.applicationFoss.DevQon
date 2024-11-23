use tauri::async_runtime::spawn;
use tauri::Manager;

use build::build::initialize as dq_init;
use commands::commands::cmd as dq_cmd;
pub fn run() {
  // Don't write code before Tauri starts, write it in the setup hook instead!
  let dev_qon_app = tauri::Builder::default()
    .plugin(tauri_plugin_shell::init())
    .invoke_handler(tauri::generate_handler![
            dq_cmd::greet,
            dq_cmd::set_complete
        ])
    .setup(|app| {
      // Use the setup hook to execute setup related tasks
      use state::state as dq_state; // Runs before the main loop, so no windows are yet created
      #[cfg(debug_assertions)]
      {
        // only include this code on debug builds
        app.get_webview_window("splashscreen")
          .unwrap()
          .open_devtools();
        app.get_webview_window("main").unwrap().open_devtools();
      }
      dq_state::initialize_app_states(app); // configure initial states for the application
      spawn(dq_init::init_setup(app.handle().clone()));

      let _base_tray = dq_init::create_base_tray(app);
      Ok(()) // The hook expects an Ok result
    })
    .on_window_event(|window, event| match event {
      tauri::WindowEvent::CloseRequested { api, .. } => {
        if window.label() == "main" {
          api.prevent_close();
          window
            .get_webview_window("main")
            .expect("main window closed")
            .hide()
            .unwrap();
        }
      }
      _ => {}
    })
    .build(tauri::generate_context!())
    .expect("error while building tauri application");

  dev_qon_app.run(|_app_handle, event| match event {
    tauri::RunEvent::ExitRequested { api, .. } => {
      api.prevent_exit();
    }
    _ => {}
  });
}
