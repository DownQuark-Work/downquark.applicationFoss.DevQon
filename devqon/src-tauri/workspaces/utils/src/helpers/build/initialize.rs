mod initialize { // user file system access should not have pub access
  use crate::helpers::standards::fsio;

  pub fn does_directory_exist() {
    println!("running internal asynchronous");
    println!("REAPPLY BELOW:")
    // let _ = fsio::read_file();
  }
  pub fn does_config_exist() {

  }
  pub fn load_config() {

  }
}

pub fn on_app_launch() -> String {
  println!("TODO3:: Update `on_app_launch(file_path_hash:HashMap<String,String>)` and then use the private methods in the above `initialize` mod.");
  println!("^^^^^^^^");println!("");println!("");
  // let root_dir = home_directory + "/.dq";
  // println!("root_dir: {}", root_dir);
  // asynchronous::does_directory_exist(home_directory);
  std::thread::sleep(std::time::Duration::from_secs(2)); // replace sleep w/ actual code
  "app launched".to_string() // after TODO3 this should return the correct enum value from the `hooks` to update the page to the correct location
}