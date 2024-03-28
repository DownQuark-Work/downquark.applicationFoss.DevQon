// https://docs.rs/sqlx/latest/sqlx/

// // No to below:
// https://docs.rs/rdbc-mysql/0.1.6/rdbc_mysql/
// https://crates.io/crates/odbc-api
// https://github.com/tauri-apps/plugins-workspace/tree/v1/plugins/sql

// https://crates.io/crates/mysql-es << serverless CQRS?

// pub mod configure;
// pub mod query;

// mod connect;

// // fn on_configure() {
// //     connect::connect_to_db();
// //   }
// connect::connect_to_db(); // todo: wrap in above type f

// private config and auth collation etc inside of this file

mod mariadb {
  pub fn get_connection_string()->String{
    "mysql://user:pass@host/database".to_string()
  }
}

pub fn db_connection()->String{
  let qualiftied_connection_string = mariadb::get_connection_string();
  println!("qualiftied_connection_string: {qualiftied_connection_string:?}");
  qualiftied_connection_string.to_string()
}