mod configure;
mod enumerate;

// Rethinking how these should work.
// At the mechanisms level let's try making these little more than macros
// - with some self contained enums / structs maybe?

// https://veykril.github.io/tlborm/ <<<<<

// NOTE: all is currently pseudo-code

// // REFERENCE
// https://docs.rs/rdbc-mysql/0.1.6/rdbc_mysql/
// https://crates.io/crates/odbc-api
// https://github.com/tauri-apps/plugins-workspace/tree/v1/plugins/sql
// https://crates.io/crates/mysql-es << serverless CQRS?
//  // may be better served as a fnc than a macro
// https://github.com/fMeow/arangors          // mod connect; mod query;
// https://docs.rs/arangors/latest/arangors   // mod connect;

// https://doc.rust-lang.org/book/ch19-06-macros.html
//   - https://doc.rust-lang.org/reference/macros-by-example.html
//   - https://doc.rust-lang.org/reference/procedural-macros.html
// > https://veykril.github.io/tlborm/ <<<<
// 
// https://doc.rust-lang.org/stable/reference/attributes.html [derive and the like]
// - https://doc.rust-lang.org/stable/reference/attributes/derive.html
// https://doc.rust-lang.org/stable/reference/attributes.html#built-in-attributes-index [attrs at your fingertips] [cfg, cfg_attr, test, etc]


// DEPRECATED
// pub mod arango;
// pub mod maria;

// // fn on_configure() {
// //     connect::connect_to_db();
// //   }
// connect::connect_to_db(); // todo: wrap in above type f
// END DEPRECATED

mod db {
  fn internal() {}
}

pub fn configure_mechanism_db() {
  println!("TODO: Make this triggered by hooks, _after_ all startup states have completed :: configuring mechanism db");
}