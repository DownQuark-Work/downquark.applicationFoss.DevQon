//! Used most often in these situations:
//! - When you have a type whose size can’t be known at compile time and you want to use a value of that type in a context that requires an exact size
//! - When you have a large amount of data and you want to transfer ownership but ensure the data won’t be copied when you do so
//! - When you want to own a value and you care only that it’s a type that implements a particular trait rather than being of a specific type
//! 
//! ### Using a `Box<T>` to Store Data on the Heap
//! ###### Listing 15-1: Storing an i32 value on the heap using a box
//! ```
//! fn main() {
//!   let b = Box::new(5);
//!   println!("b = {}", b);
//! }
//! ```
//!Putting a single value on the heap isn’t very useful, so you won’t use boxes by themselves in this way very often.
//! Having values like a single i32 on the stack, where they’re stored by default, 
//!   is more appropriate in the majority of situations. 
//! Let’s look at a case where boxes allow us to define types that we wouldn’t be allowed to if we didn’t have boxes. 

/// ### Enabling Recursive Types with Boxes
/// At compile time, Rust needs to know how much space a type takes up. 
/// One type whose size can’t be known at compile time is a recursive type, 
///   where a value can have as part of itself another value of the same type. 
/// Because this nesting of values could theoretically continue infinitely, 
///   Rust doesn’t know how much space a value of a recursive type needs. 
/// However, boxes have a known size, so by inserting a box in a recursive type definition, 
///   you can have recursive types.
///  > NOTE: Info about the `cons list` [here](https://doc.rust-lang.org/book/ch15-01-box.html#more-information-about-the-cons-list)
///  >> But basically just a linked list/Iterator:
///  >>> _Each item in a cons list contains two elements: the value of the current item and the next item. The last item in the list contains only a value called Nil without a next item._

// Note: We’re implementing a cons list that holds only i32 values for the purposes of this example. We could have implemented it using generics, as we discussed in Chapter 10, to define a cons list type that could store values of any type.

enum List {
    Cons(i32, Box<List>),
    Nil,
}
use crate::List::{Cons, Nil};

pub fn main_boxt() {
  let list = Cons(1, Box::new(Cons(2, Box::new(Cons(3, Box::new(Nil))))));
}
