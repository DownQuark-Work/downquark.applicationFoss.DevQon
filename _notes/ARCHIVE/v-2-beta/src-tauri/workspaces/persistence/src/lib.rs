#![allow(dead_code)]

use std::collections::HashMap;

mod database;
mod protocol;

#[derive(Debug)]
pub enum EnumPersistenceTypes{
  Unset, // N/A
  DatabaseArango, DatabaseMaria, // Database
  DatabaseMariaDownQuark,DatabaseMariaDevQon, // Database Table
  ProtocolEthereum, // Web3
}
// want control over when to access as a string vs true enum
impl EnumPersistenceTypes {
  pub fn get_string_keys(&self)->String {
    // println!("internal {:?}", self);
    match self {
      EnumPersistenceTypes::DatabaseMariaDownQuark => "DatabaseMariaDownQuark".to_string(),
      EnumPersistenceTypes::DatabaseMariaDevQon => "DatabaseMariaDevQon".to_string(),
      _=> "No default allowed".to_string(),
    }
  }
}

// pub struct OnAppLaunchStruct {
//   init_view:EnumStateAppView,
//   version_update_available:bool,
// }
// impl OnAppLaunchStruct {
//   pub fn get_app_launch_conf(&self) -> (&EnumStateAppView, bool) {
//     (&self.init_view,self.version_update_available)
//   }
// }

// end result is that _all_ calls relating to this workspace should only access this file.
// - this will be extended to whatever is required to retrieve and distribute the information needed

pub fn config_persistent(persistent_type:&EnumPersistenceTypes) -> &EnumPersistenceTypes {
  println!("persisting: {:?}", persistent_type);
  match persistent_type {
    EnumPersistenceTypes::ProtocolEthereum => {
      // protocol::configure_connection(persistent_type)
      println!("PROTOCAL TYPE CALLED: {:?}", persistent_type);},
    EnumPersistenceTypes::DatabaseArango|EnumPersistenceTypes::DatabaseMaria => {
      database::configure_connection(&persistent_type)},
    _ => {println!("Throwing because type DNE: {:?}", persistent_type);}
  };
  persistent_type
}

pub async fn on_application_startup_query(db_config:HashMap<String,String>) {
  // for (db_ref, connection_str) in db_config.iter() {
  //   println!("db_ref: {db_ref:?}");
  //   println!("awaiting connection_str: {connection_str:?}");
  //   database::create_connection(&EnumPersistenceTypes::DatabaseMaria,connection_str).await;
  //   println!("awaited connection_str: {connection_str:?}");    
  // };

  let db_startup_connection_first = db_config.get("DatabaseMariaDownQuark").unwrap();
  let db_startup_connection_last = db_config.get("DatabaseMariaDevQon").unwrap();

  database::create_connection(&EnumPersistenceTypes::DatabaseMaria,db_startup_connection_first).await;
  database::create_connection(&EnumPersistenceTypes::DatabaseMaria,db_startup_connection_last).await;
}

pub fn request_persistent_data(persistent_type:&EnumPersistenceTypes,data_req:&str)->String{
  println!("match where to route the data and do so:"); // obviously with a ~helper/util~ macro of some sort
  println!("then (from method) return the fully parsed data to where it came from");
  let ret_data = "Here's your Data".to_owned() + data_req;
  match persistent_type {
    EnumPersistenceTypes::ProtocolEthereum => {
      println!("PROTOCAL TYPE CALLED: {:?}", persistent_type);},
    EnumPersistenceTypes::DatabaseArango|EnumPersistenceTypes::DatabaseMaria => {
      database::route_query_to_db(&persistent_type,&data_req)},
    _ => {println!("Throwing because type DNE: {:?}", persistent_type);}
  };
  ret_data.to_string()
}