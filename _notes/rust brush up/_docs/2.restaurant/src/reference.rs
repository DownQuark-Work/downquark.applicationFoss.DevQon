use std::fmt::Display;

//traits
pub trait Summary {
    fn summarize_author(&self) -> String;

    fn summarize(&self) -> String {
        format!("(Read more from {}...)", self.summarize_author())
    }
}

pub struct NewsArticle {
    pub headline: String,
    pub location: String,
    pub author: String,
    pub content: String,
}
pub struct Tweet {
    pub username: String,
    pub content: String,
    pub reply: bool,
    pub retweet: bool,
}

// Uncomment below to remove default behavior for NewsArticle
// impl Summary for NewsArticle {
//     fn summarize(&self) -> String {
//         format!("{}, by {} ({})", self.headline, self.author, self.location)
//     }
// }
impl Summary for Tweet {
  fn summarize_author(&self) -> String {
    format!("@{}", self.username)
  }
  fn summarize(&self) -> String {
    format!("{}: {}", self.username, self.content)
  }
}

  //Define a notify function that calls the summarize method on its item parameter,
// pub fn notify(item: impl Summary) {  <-- Same as below
pub fn notify<T: Summary>(item: T) {
    println!("Breaking news! {}", item.summarize());
}
  // generics allow passing more than one type as well:
// pub fn notify(item1: impl Summary, item2: impl Summary) {} // non-generic | must have same types
// pub fn notify<T: Summary>(item1: T, item2: T) { } // generic | can have different types

//Specifying Multiple Trait Bounds with the + Syntax
  //Want notify to use display formatting on item as well as the summarize method
  // Use + to specify that item must implement both Display and Summary
/*
pub fn notify(item: impl Summary + Display) {}
pub fn notify<T: Summary + Display>(item: T) {}
*/

//Clearer Trait Bounds with where Clauses
  // Getting too long?
// fn some_function<T: Display + Clone, U: Clone + Debug>(t: T, u: U) -> i32 {
  // Use where clause
/*
  fn some_function<T, U>(t: T, u: U) -> i32
    where T: Display + Clone,
          U: Clone + Debug
  {}
*/

// Returning Types that Implement Traits
fn returns_summarizable() -> impl Summary {
    Tweet {
        username: String::from("horse_ebooks"),
        content: String::from("of course, as you probably already know, people"),
        reply: false,
        retweet: false,
    }
}
  //NOTE: You can only use impl Trait if you’re returning a single type
    // below would fail
/*
fn returns_summarizable(switch: bool) -> impl Summary {
    if switch { NewsArticle {...} }
        else { Tweet {...} }
}
*/

// largest with trait bounds
pub fn largest<T: PartialOrd + Copy>(list: &[T]) -> T {
  let mut largest = list[0];
  for &item in list.iter() {
    if item > largest { largest = item; }
  }
  largest
}
//Usage
/*
fn get_largest() {
    let number_list = vec![34, 50, 25, 100, 65];
    let result = largest(&number_list);
    println!("The largest number is {}", result);

    let char_list = vec!['y', 'm', 'a', 'q'];
    let result = largest(&char_list);
    println!("The largest char is {}", result);
}
*/

// Conditionally implement methods on a generic type depending on trait bounds
  // use std::fmt::Display; <-- imported at top
struct Pair<T> {
    x: T,
    y: T,
}
impl<T> Pair<T> { // Pair<T> always implements the new function
  fn new(x: T, y: T) -> Self {
    Self { x, y, }
  }
}
// Pair<T> Only implements the cmp_display method if its
  // inner type T implements the PartialOrd trait that enables comparison
  // and the Display trait that enables printing
impl<T: Display + PartialOrd> Pair<T> {
  fn cmp_display(&self) {
    if self.x >= self.y { println!("The largest member is x = {}", self.x); }
    else { println!("The largest member is y = {}", self.y); }
  }
}