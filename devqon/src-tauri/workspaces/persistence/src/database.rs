mod common_queries;
mod arango;
mod maria;

use crate::EnumPersistenceTypes;
// // fn on_configure() {
// //     connect::connect_to_db();
// //   }
// connect::connect_to_db(); // todo: wrap in above type f

mod db {
  fn configure_connection_arango() {}
}

pub fn configure_connection(db_type:&EnumPersistenceTypes) {
  println!("db_type: {db_type:?}");
  // this would be dynamic when not stubbed
  let configured_connection = maria::db_connection();
  println!("configured_connection: {configured_connection:?}");
}

pub async fn create_connection(db_type:&EnumPersistenceTypes,connection_str:&str) {
  println!("create_connection: db_type: {db_type:?}");
  println!("create_connection: connection_str: {connection_str:?}");
  // // todo: let match here for arango v maria:
  println!("awating: ");
  let db_connection = maria::db_connect(connection_str).await;
  println!("awat3d: ");
  let _ = maria::run_query(db_connection.unwrap(),"").await;
}

pub fn route_query_to_db(db_type:&EnumPersistenceTypes,routed_query:&str) {
  println!("route_query_to_db db_type: {db_type:?}");
  println!("routed_query: {routed_query:?}");
  maria::db_run_query();
}