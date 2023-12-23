mod front_of_house; // semicolon instead of block tells rust to load module with same name

pub mod back_of_house {
    #[derive(Debug)]
    pub enum Appetizer {
        Soup,
        Salad,
    }
    pub struct Breakfast {
        pub toast: String,
        seasonal_fruit: String,
    }

    impl Breakfast {
        pub fn summer(toast: &str) -> Breakfast {
            Breakfast {
                toast: String::from(toast),
                seasonal_fruit: String::from("peaches"),
            }
        }
    }

    fn fix_incorrect_order() {
        cook_order();
        super::serve_order();
    }

    fn cook_order() {}
}

mod reference;
    //fn and methods, scope to parent (call hosting::fn())
        // make sure to mark `pub` if want to be used externally from crate
//private
// use crate::front_of_house::hosting;
//public
pub use crate::front_of_house::hosting;
pub use crate::back_of_house::{Appetizer, Breakfast};
    //structs enums items, scope full path
//e.g.: use std::collections::HashMap; (call HashMap::new())
    //use "as" when needed
//use std::fmt::Result;
//use std::io::Result as IoResult;
    //nest when needed
// use std::{cmp::Ordering, io};
// use std::io::{self, Write}; --> brings in std::io AND std::io::Write
    //supports glob
// use std::collections::*;

// private, cannot be called from outside crate
fn serve_order() {}

// pub functions OUTSIDE of mods can be called when crate is installed
pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();

    let order1 = back_of_house::Appetizer::Soup;
    let order2 = back_of_house::Appetizer::Salad;
    println!("Orders are: {:?} and {:?}", order1, order2);
    // Order a breakfast in the summer with Rye toast
    let mut meal = back_of_house::Breakfast::summer("Rye");
    // Change our mind about what bread we'd like
    meal.toast = String::from("Wheat");
    println!("I'd like {} toast please", meal.toast);

    // The next line won't compile if we uncomment it; we're not allowed
    // to see or modify the seasonal fruit that comes with the meal
    // meal.seasonal_fruit = String::from("blueberries");
}

// Unit Tests within each module
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn breakfast() {
        let meal = Breakfast::summer("Rye");
        assert_eq!(String::from("Rye"), meal.toast);
    }
}