// after getting connection from `./connect.rs`
// do whatever is required to make the below happen
// ```
// // qry!(AQL"INSERT { name: "John Doe", gender: "m" } INTO users")
// // qry!(SQL"INSERT INTO users (name, gender) VALUES (\"John Doe\", \"m\");")
// ```

// pub fn raw() {
//   println!("[maria ]> arg1");
//   println!("run qry() with above");
//   qry();
// }

// pub fn select() {
//   println!("[maria ]> SELECT arg1 FROM arg2");
//   println!("run qry() with above");
//   qry();
// }

// fn qry() {
//   println!("[maria ]> Query database");
// }