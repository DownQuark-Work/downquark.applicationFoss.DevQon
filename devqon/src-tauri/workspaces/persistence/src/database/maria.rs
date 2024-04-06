use sqlx::MySqlPool;

use super::common_queries;

mod mariadb {
  pub fn get_connection_string()->String{
    "mysql://user:pass@host/database".to_string()
  }
}

pub async fn db_connect(conn_str:&str) -> Result<MySqlPool, sqlx::Error> {
  println!("conn_str: {conn_str:?}");
  let pool = MySqlPool::connect(conn_str).await?;
  Ok(pool)
}
pub async fn run_query(cnx:MySqlPool, query:&str) -> Result<(), sqlx::Error> {
  let row: (i64,) = sqlx::query_as("SELECT ?")
    .bind(150_i64)
    .fetch_one(&cnx).await?;
  assert_eq!(row.0, 150);
  println!(">>>>row: {:?}",row);
  Ok(())
}

pub fn db_connection()->String{
  let qualiftied_connection_string = mariadb::get_connection_string();
  println!("qualiftied_connection_string: {qualiftied_connection_string:?}");
  qualiftied_connection_string.to_string()
}

pub fn db_run_query()->String{
  println!("match where to route the data and do so:"); // obviously with a ~helper/util~ macro of some sort
  println!("then (from method) return the fully parsed data to where it came from");
  println!("-- mocking only maria for examples");
  let _user_authenticated = common_queries::run_common_query(common_queries::EnumCommonQuery::AuthenticateUser);
  "-- mocking only maria for examples".to_string()
}

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