/*
  The top-level Cargo.lock now contains information about the dependency of add-two on rand.
  However, even though rand is used somewhere in the workspace, 
    we can’t use it in other crates in the workspace unless we add rand to their Cargo.toml files as well. 
  For example, if we add use rand; to the adder/src/main.rs file for the adder crate, we’ll get an error:
*/
use rand;

/// Adds two to the number given.
///
/// # Examples
///
/// ```
/// let arg = 5;
/// let answer = add_two::add_two(arg);
///
/// assert_eq!(7, answer);
/// ```
pub fn add_two(x: i32) -> i32 {
    x + 2
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        assert_eq!(4, add_two(2));
    }
}