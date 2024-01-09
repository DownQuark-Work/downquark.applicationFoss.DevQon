//! # Functional Crate
//!
//! `functional` is chapter 13-14 of 
//!   https://doc.rust-lang.org/book
//! > Another style of doc comment, `//!`, adds documentation to the item that contains the comments
//! > rather than adding documentation to the items following the comments. 
//!
//! > We typically use these doc comments inside the crate root file (src/lib.rs by convention) 
//! > or inside a module to document the crate or the module as a whole.


/// Closures modz
///
/// # With
/// ### markdown
///
/// ```
/// let mut str = "hello world";
/// ```
pub mod closures;

/// Iterators modx
///
/// # 3 slashes
/// ### _are_ what **allow** markdown
///
/// ```text
/// $ not rust code - use "text" helper
/// ```
/// run `$ cargo doc`
/// For convenience, running `$ cargo doc --open` will build the HTML for your current crate’s documentation
/// (as well as the documentation for all of your crate’s dependencies) and open the result in a web browser
pub mod iterators;