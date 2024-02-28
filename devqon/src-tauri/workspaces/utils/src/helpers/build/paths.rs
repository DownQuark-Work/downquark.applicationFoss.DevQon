use tauri::{AppHandle,Manager};
use std::collections::HashMap;

pub fn get_sys_paths(app_handle: &AppHandle) -> String {
  // pub fn get_sys_paths(app_handle: &AppHandle) -> HashMap<&str, String> {
  let home_directory_bind = app_handle.path().parse("$HOME");
  let home_directory = home_directory_bind.expect("no folder exists").to_str().unwrap().to_string();
  let resource_directory = app_handle.path().parse("$RESOURCE").expect("no folder exists");
  let application_directory = resource_directory.parent().expect("root dir").parent().expect("root dir").parent().expect("root dir").parent();
  println!("PATH:: resource_directory: {:?}",application_directory.expect("root dir").to_str().unwrap());
  println!("PATH:: home_directory: {:?}", home_directory);

  println!("");println!("");println!("vvvvvvvv");
  println!("TODO1:: Return a hashmap from here like below -- use Home:~, DQ: ~/.dq, DevQon:~/.dq/devqon");

  // let sys_conf_paths:HashMap<&str, > = HashMap::from(["HOME",&home_directory]);
  // sys_conf_paths
  // .insert(std_time::epoch_ms(),current_state_enum);
  // println!("ZXC::home_directory: {:?}",sys_conf_paths);
  "howdy".to_string()
}