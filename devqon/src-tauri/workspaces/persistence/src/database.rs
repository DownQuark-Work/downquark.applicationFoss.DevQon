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

pub fn configure_connection(db_type:EnumPersistenceTypes) {
  println!("db_type: {db_type:?}");
  // this would be dynamic when not stubbed
  let configured_connection = maria::db_connection();
  println!("configured_connection: {configured_connection:?}");
}