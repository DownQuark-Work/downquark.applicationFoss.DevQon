use super::enumerate;
use std::sync::Mutex; // maybe just a mutable, stored, struct?

struct DatabaseConfig {
  connection_url:Mutex<String>,
  database_type:Mutex<enumerate::EnumMechanismDatabaseType>,
  username:Mutex<String>,
  password:Mutex<String>,
}

trait ConfigureMechanismDb {
  fn with_config();
}

pub fn config_db() {
  println!("configuring database");
}

// Above is pseudo-code for Attribute-like macros
// - would be called with something similar to:
// ```
// #[proc_macro_attribute]
// pub fn configure_mechanism_db(db_config:DatabaseConfig) {
//   let _ = DatabaseConfig {
//     db_config
//   }
// }
// ````
// then
// ````
// #[configure_mechanism_db]
// DatabaseConfig {
//   connection_url:"arango://yad.da.yadda",
//   database_type:EnumMechanismDatabaseType::ARANGODB,
//   username:"downquark",
//   password:"work",
// }
// ```
// results in:
// the struct local to this file being mutated and stored locally
//    for the remainder of the users current session
//    with those config settings
