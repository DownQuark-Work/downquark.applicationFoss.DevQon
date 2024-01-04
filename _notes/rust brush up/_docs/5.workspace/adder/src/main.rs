//! The workspace has one target directory at the top level for the compiled artifacts to be placed into;
//!   the adder crate doesn’t have its own target directory. 
//!
//! Even if we were to run cargo build from inside the adder directory, 
//!   the compiled artifacts would still end up in _**add/target**_ rather than _add/adder/target_
//!

/// import `add_one` to print a math equation
use add_one;
use add_two;


/// Uses `add_one` AND `add_two` to print math equations
fn main() {
    let num = 10;
    println!(
        "Hello, world! {} plus ONE is {}!",
        num,
        add_one::add_one(num)
    );
    println!(
        "Hello, world! {} plus TWO is {}!",
        num,
        add_two::add_two(num)
    );
}