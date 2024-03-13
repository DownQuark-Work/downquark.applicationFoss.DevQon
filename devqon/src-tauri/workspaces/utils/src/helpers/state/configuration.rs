use std::collections::HashMap;
use tauri::{AppHandle, Manager };
use crate::configuration::DevQonConfig;

pub fn set_app_configuration(sys_conf_paths:HashMap<&str, String>,app_handle: &AppHandle){
  let devqon_config = DevQonConfig::make_config(sys_conf_paths);
  app_handle.manage(devqon_config.unwrap());
  app_handle.state::<DevQonConfig>();
}

/*
    struct ApplicationWindow {
  history: Mutex<HashMap<u128, enumerate::EnumStateAppWindow>>,
  visible: Mutex<bool>,
}
  fn toggle_system_tray_hide_menu_item(app_handle: &tauri::AppHandle) {
  let app_state_window = app_handle.state::<ApplicationWindow>();
     */