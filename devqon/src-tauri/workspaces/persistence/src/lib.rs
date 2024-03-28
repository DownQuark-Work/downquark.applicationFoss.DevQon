#![allow(dead_code)] // TODO: remove this when workspaces are implemented
mod database;
mod protocol;

#[derive(Debug)]
pub enum EnumPersistenceTypes{
  Unset,
  DatabaseArango, DatabaseMaria,
  ProtocolEthereum,
}

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

pub fn request_persistent_data(persistent_type:&EnumPersistenceTypes,data_req:&str)->String{
  println!("match where to route the data and do so:"); // obviously with a helper/util of some sort
  println!("then (from method) return the fully parsed data to where it came from");
  let mut ret_data = "Here's your Data".to_owned() + data_req;
  match persistent_type {
    EnumPersistenceTypes::ProtocolEthereum => {
      println!("PROTOCAL TYPE CALLED: {:?}", persistent_type);},
    EnumPersistenceTypes::DatabaseArango|EnumPersistenceTypes::DatabaseMaria => {
      database::route_query_to_db(&persistent_type,&data_req)},
    _ => {println!("Throwing because type DNE: {:?}", persistent_type);}
  };
  ret_data.to_string()
}