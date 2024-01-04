//Tests written here act as though they're called from outside the compiled crate
  // what users would really be able to access, etc.
use restaurant::back_of_house::{Appetizer, Breakfast};

#[test]
fn integrate_breakfast() {
  let meal = Breakfast::summer("Whiskey");
  assert_eq!(String::from("Whiskey"), meal.toast);
}