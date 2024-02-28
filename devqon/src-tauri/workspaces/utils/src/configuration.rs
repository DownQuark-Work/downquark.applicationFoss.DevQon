use config::{Config, ConfigError, Environment, File};
use std::env;

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
struct DownQuark {
  application: String,
  root_directory:Vec<String>,
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
struct DevQonLogging {
  level: String,
  output: Vec<String>,
}

#[derive(Debug,serde::Deserialize)]
#[allow(unused)]
struct DevQon {
  auto_update: bool,
  debug: bool,
  directory: DevQonDirectory,
  logging: DevQonLogging,
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
  _dq:DownQuark,
  devqon:DevQon,
  todo:ToDo,
}

impl DevQonConfig {
  pub fn make_config(app_dir:&str) -> Result<Self, ConfigError> {
    let config_directory = app_dir.to_owned()+"/devqon/src-tauri/config/"; // concat full application path with config dir path
    let run_env = env::var("RUN_ENV").unwrap_or_else(|_| "development".into()); // Default to 'development' env
    let devQonConf = Config::builder() // as sources are added below duplicate keys will overwrite previously defined values
        .add_source(File::with_name(&(config_directory.clone()+"_default"))) // default configuration file
        .add_source(File::with_name(&(config_directory.clone()+&format!("{}", run_env))) // file with env overrides - defaulted to 'development' above
            .required(false),) // optional file - does not throw if file DNE
        .add_source( // optional local configuration file - ensure locality by omitting from repository
          File::with_name(&(config_directory.clone()+"local")).required(false))
          // below applies cli variables specified by given prefix
        .add_source(Environment::with_prefix("dq")) // `DQ_DEBUG=1 ./target/app` would set the `debug` key to true
        .add_source(Environment::with_prefix("devqon")) // `DEVQON_DEBUG=0 DQ_DEBUG=1 ./target/app` would immediately overwrite the `debug` key to be false
        // .set_override("database.url", "postgres://")? // For future reference: to programmatically change settings
        .build()?;

    // Proof of concept
    // println!("debug: {:?}", devQonConf.get_bool("devqon.debug"));
    // println!("database: {:?}", devQonConf.get::<Vec<String>>("_dq.root_directory"));

    // deserialize, freeze, and return configuration
    devQonConf.try_deserialize()
  }
}
