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

pub fn config_persistent(persistent_type:EnumPersistenceTypes) {
  println!("persisting: {:?}", persistent_type);
  match persistent_type {
    EnumPersistenceTypes::ProtocolEthereum => { println!("PROTOCAL TYPE CALLED: {:?}", persistent_type);},
    _ => database::confiigure_connection(persistent_type)
  };
}

pub fn request_data(){
  println!("match where to route the data and do so:");
  println!("then (from method) return the fully parsed data to where it came from");
}