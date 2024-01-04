//! # Smart Pointers Crate
//!
//! `smart_pointers` is chapter 15 of 
//!   https://doc.rust-lang.org/book


/// box mod
///
/// # Using `Box<T>` to Point to Data on the Heap
/// 
/// The most straightforward _smart pointer_ is a box, whose type is written `Box<T>`.
/// Boxes allow you to store data on the heap rather than the stack. 
/// What remains on the stack is the pointer to the heap data.
/// Refer to Chapter 4 to review the difference between the stack and the heap.
/// 
pub mod boxt;