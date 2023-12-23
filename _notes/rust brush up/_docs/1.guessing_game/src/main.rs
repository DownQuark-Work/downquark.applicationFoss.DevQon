use std::io;
use std::cmp::Ordering; // cmp -> compare || Ordering -> enum: [Less, Greater, and Equal]
use std::collections::HashMap;
use std::fmt::Display;
use std::net::{/*IpAddr,*/ Ipv4Addr, Ipv6Addr};
use rand::{thread_rng, Rng};

#[derive(Debug)] // allows :? to be used in println! below
struct Rectangle {
    width: u32,
    height: u32,
}
// NOTE: Here’s how it works: when you call a method with object.something(),
  // Rust automatically adds in &, &mut, or * so object matches the signature of the method.
  // In other words, the following are the same:
/*
  p1.distance(&p2);
  (&p1).distance(&p2);
*/
impl Rectangle { // creates method on the struct
  fn square(size: u32) -> Rectangle { Rectangle { width: size, height: size } }
  fn area_method(&self) -> u32 { self.width * self.height }
  fn can_hold(&self, other: &Rectangle) -> bool { self.width > other.width && self.height > other.height }
}


fn main() {

  // BEGIN Snippets
  //// fn
  let mut x = 5;
  println!("The value of x is: {}", x);
  let y = {
      x = 3;
      x + 1 // Note the x + 1 line without a semicolon at the end,
        // which is unlike most of the lines you’ve seen so far. 
        // Expressions do not include ending semicolons.
        //  If you add a semicolon to the end of an expression, you turn it into a statement, 
          // which will then not return a value. Keep this in mind with function return values and expressions
  };
  println!("The value of y is: {}", y);
    // fn with return
  x = plus_one(5);
  println!("The value of x is: {}", x);

  fn plus_one(x: i32) -> i32 { // thin arrow for return type
      // x + 1; // ERROR: ^^^ expected `i32`, found `()` -- - help: consider removing this semicolon
      x + 1 // no semi-colon works (see comment above [line13-17])
  }
  //// end fn

  //// loops
  let a = [10, 20, 30, 40, 50];
  let mut index = 0;

    while index < 5 {
        println!("the value is: {}", a[index]);

        index += 1;
    }

    for element in a.iter() {
        println!("the value is: {}", element);
    }

  for number in (1..4).rev() {
        println!("{}!", number);
    }
    println!("LIFTOFF!!!");
  //// end loops

  //// memory
  //OWNED types like String instead of REFERENCE type like &str.
  // This kind of string can be mutated:
  let mut s = String::from("hello");
  s.push_str(", world!"); // push_str() appends a literal to a String
  println!("{}", s); // This will print `hello, world!`
// So, what’s the difference here? Why can String be mutated but literals cannot? 
  // The difference is how these two types deal with memory.

//--MOVE
  let s1 = String::from("hello");
  let _s2 = s1; // copies data and invalidates original
  // println!("{}, world!", s1); // ERROR: -- value moved here (s2 = s1) value used here after move
//--COPY
let s1 = String::from("hello");
let s2 = s1.clone();
println!("s1 = {}, s2 = {}", s1, s2); // works fine

// Annotated Memory Example
fn annotated_memory_example() {
  let _s1 = gives_ownership(); // gives_ownership moves its return value into s1
  let s2 = String::from("hello"); // s2 comes into scope
  let _s3 = takes_and_gives_back(s2); // s2 is moved takes_and_gives_back, which also moves its return value into s3
} // Here, s3 goes out of scope and is dropped. s2 goes out of scope but was
    // moved, so nothing happens. s1 goes out of scope and is dropped.
fn gives_ownership() -> String { // gives_ownership will move its return value into the function that calls it
  let some_string = String::from("hello"); // some_string comes into scope
  some_string // some_string is returned and moves out to the calling function
}
// takes_and_gives_back will take a String and return one
fn takes_and_gives_back(a_string: String) -> String { // a_string comes into scope
  a_string  // a_string is returned and moves out to the calling function
}
annotated_memory_example();
// Return Tuple
fn return_tuple() {
  let s1 = String::from("hello");
  let (s2, len) = calculate_length(s1);
  println!("The length of '{}' is {}.", s2, len);
}
fn calculate_length(s: String) -> (String, usize) {
    let length = s.len(); // len() returns the length of a String
    (s, length)
}
return_tuple();
// The issue with the tuple code in Listing 4-5 is that we have to return the 
  // String to the calling function so we can still use the String after the 
  // call to calculate_length, because the String was moved into calculate_length.
// Here is how you would define and use a calculate_length function that has a reference
  // to an object as a parameter instead of taking ownership of the value:

// NOTE: The opposite of referencing by using & is dereferencing, which is accomplished with the dereference operator, *.

fn reference_example() {
    let mut s1 = String::from("hello");
    // change(&s1); // cannot mutate borrowed var
    change(&mut s1); // pass var as mutable
    let len = calculate_length_by_ref(&s1);
    println!("The length of '{}' is {}.", s1, len);
}
fn calculate_length_by_ref(s: &String) -> usize { s.len() }
// fn change(some_string: &String) { some_string.push_str(", world"); } // ERROR: cannot borrow as mutable
fn change(some_string: &mut String) { some_string.push_str(", MUTABLE world"); } // mark param as mutable for it to work
reference_example();
// Mutable references have one big restriction:
  // you can have only ONE mutable reference to a particular piece of data in a particular scope
    /*
    fn FAIL_race_cond_example() { // ERROR: cannot borrow `s` as mutable more than once at a time
      let mut s = String::from("hello");
      let r1 = &mut s; // first mutable borrow occurs here
      let r2 = &mut s; // second mutable borrow occurs here
      println!("{}, {}", r1, r2); // first borrow later used here
    }
    */
// Use curly brackets to create a new scope,
  // allowing for multiple mutable references,
  // just not simultaneous ones
  fn race_cond_example() {
    let mut s = String::from("hello");
  { let r1 = &mut s;  println!("r1:{}",r1)} // r1 goes out of scope here, so we can make a new reference with no problems.
  let r2 = &mut s; // s is moved to r2 -out of scope
  println!("r2:{}", r2);
}
race_cond_example();
// Similar rule exists for (im)mutable mixed conditions
/*
fn FAIL_mixed_mutable_cond() { // ERROR: cannot borrow `s` as mutable because it is also borrowed as immutable
  let mut s = String::from("hello");
  let r1 = &s; // no problem || immutable borrow occurs here
  let r2 = &s; // no problem
  let r3 = &mut s; // BIG PROBLEM || mutable borrow occurs here
  println!("{}, {}, and {}", r1, r2, r3); // immutable borrow later used here
}
*/
// Note that a reference’s scope starts from where it is introduced and continues through 
  // the last time that reference is used.
// For instance, this code will compile because the last usage of the immutable references 
  // occurs before the mutable reference is introduced:
fn mixed_mutable_cond() {
  let mut s = String::from("hello");
  let r1 = &s; // no problem
  let r2 = &s; // no problem
  println!("{} and {}", r1, r2);
    // r1 and r2 are no longer used after this point
  let r3 = &mut s; // no problem
  println!("r3: {}", r3);
}
mixed_mutable_cond();
// Dangling References
// In languages with pointers, it’s easy to erroneously create a dangling pointer, 
  // a pointer that references a location in memory that may have been given to someone else, 
  // by freeing some memory while preserving a pointer to that memory. 
// In Rust, by contrast, the compiler guarantees that references will never be dangling references:
  // if you have a reference to some data, the compiler will ensure that the data will NOT go out of scope
    // before the reference to the data does.
  /*
    fn FAIL_dangle_example() { let reference_to_nothing = FAIL_dangle(); } // ERROR: missing lifetime specifier
    fn FAIL_dangle() -> &String { let s = String::from("hello"); &s } // -> &String expected lifetime parameter
      // = help: this function's return type contains a borrowed value,
        // but there is no value for it to be borrowed from [<-- actual issue]
      // = help: consider giving it a 'static lifetime [Not Applicable Here]
  */
  fn dangle_example() { let reference_to_nothing = dangle(); println!("dangle: {}", reference_to_nothing); }
  fn dangle() -> String { let s = String::from("hello"); s }// s loses scope here if not moved to above
  // - if returned &s the pointer would have nothing to point to SO return non-pointer value
  dangle_example();
  
  //-- SLICE TYPE

  // Here’s a small programming problem: write a function that takes a string and returns the first word
    // it finds in that string. If the function doesn’t find a space in the string, 
    // the whole string must be one word, so the entire string should be returned.
fn first_world_example() {
  let mut snolit = String::from("hello world");
  let slit = "literal-hello world"; // The type of s here is &str: it’s a slice pointing to that specific point of the binary.
    // This is also why string literals are immutable; &str is an immutable reference.
  let len = slit.len();
  let hello = &slit[0..5]; // capture pattern is: [..)
  let world = &slit[6..11];
  let slice1 = &slit[0..2]; // slice1 is equal to slice2
  let slice2 = &slit[..2];
  let slice3 = &slit[3..len]; // slice3 is equal to slice4
  let slice4 = &slit[3..];
  println!("--> {}, {}, {}, {}, {}, {}",hello, world, slice1, slice2, slice3, slice4);

  // first_word works on slices of `String`s
  let word = first_word(&snolit[..]); // first_word works on slices of `String`s
  let wordlit = first_word(&slit[..]); // first_word works on slices of string literals
  // Because string literals *are* string slices already, this works too, without the slice syntax!
  println!("first word --> {}, {}",word,wordlit);
  snolit.clear(); // IF mutable then this empties the String, making it equal to ""
    // word still has the value 5 here, but there's no more string that
    // we could meaningfully use the value 5 with. word is now totally invalid!
  let a = [1, 2, 3, 4, 5];
  let a_slice = &a[1..3];
  println!("a_slice({}): {} - {}",a_slice.len(), a_slice[0],a_slice[1]);
  println!("a_slice DEBUG: {:?}",a_slice);
}
// fn first_word(s: &String) -> &str { // works, but only allows &String types
fn first_word(s: &str) -> &str { // allows us to use the same function on both &String values and &str values.
  let bytes = s.as_bytes();
  for (i, &item) in bytes.iter().enumerate() {
    if item == b' ' {
      return &s[0..i];
    }
  }
  &s[..]
}
first_world_example();
  //// end memory

  //// structs
  let rect1 = (30, 50); // tuple
  println!( "TUPLE: The area of the rectangle is {} square pixels.", area(rect1) );
  fn area(dimensions: (u32, u32)) -> u32 { dimensions.0 * dimensions.1 } // tuple version
  let rect2 = Rectangle { width: 30, height: 50 }; // struct defined at top
  let rect3 = Rectangle { width: 10, height: 40 };
  let rect4 = Rectangle { width: 60, height: 45 };
  let square = Rectangle::square(30);
  fn struct_area(rectangle: &Rectangle) -> u32 { rectangle.width * rectangle.height }
  println!( "STRUCT: The area of the rectangle is {} square pixels.", struct_area(&rect2) );
  println!("rect2 DEBUG is {:?}", rect2);
  println!("rect2 DEBUG EXPAND is {:#?}", rect2);
  println!("rect2 IMPLEMENTATTION METHOD (impl) is {} px^2", rect2.area_method());
  println!("ANOTHER IMPLEMENTATION");
  println!("Can rect2 hold rect3? {}", rect2.can_hold(&rect3));
  println!("Can rect3 hold rect4? {}", rect3.can_hold(&rect4));
  println!("CREATION IMPLEMENTATION");
  println!("square DEBUG is {:?}", square);
  //// end structs

  //// enums
  /* READ through below
    enum IpAddrKind { // declare
      V4,
      V6,
    }
    struct IpAddr {
      kind: IpAddrKind,
      address: String,
    }
    let home = IpAddr {
      kind: IpAddrKind::V4,
      address: String::from("127.0.0.1"),
    };

    let loopback = IpAddr {
      kind: IpAddrKind::V6,
      address: String::from("::1"),
    };
  */
  // ALL of the above can be shortened to:
  /* READ below
  enum IpAddr {
    V4(String),
    V6(String),
  }
  let home = IpAddr::V4(String::from("127.0.0.1"));
  let loopback = IpAddr::V6(String::from("::1"));
  */
  // then check out the standard lib (imported at top of file)
  #[derive(Debug)]
  enum IpAddr {
    V4(Ipv4Addr),
    V6(Ipv6Addr),
  }
  let _ipv_four = IpAddr::V4(Ipv4Addr::new(224, 254, 0, 0));
  let _ipv_six = IpAddr::V6(Ipv6Addr::new(0xff00, 0, 0, 0, 0, 0, 0, 0));
  println!("Correct IPs: {:#?},{:#?}",_ipv_four,_ipv_six);

//// A Message enum whose variants each store different amounts and types of values
#[derive(Debug)]
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}
// Above COULD be defined as structs
/*
  struct QuitMessage; // unit struct
  struct MoveMessage { x: i32, y: i32, }
  struct WriteMessage(String); // tuple struct
  struct ChangeColorMessage(i32, i32, i32); // tuple struct
*/
// But if we used the different structs, which each have their own type, 
  // we couldn’t as easily define a function to take any of these kinds of 
  // messages as we could with the Message enum
//---
// One more similarity between enums and structs: 
  // just as we’re able to define methods on structs using impl, we’re also able to define methods on enums
  impl Message {
    fn call(&self) {
        // method body would be defined here
    }
}
let q = Message::Quit;
let mv = Message::Move {x:30, y:72};
let m = Message::Write(String::from("hello"));
let cc = Message::ChangeColor(5,12,18);
m.call();
cc.call();
println!("MESSAGE: {:?},{:?},{:?},{:?},", q,mv,m,cc);
//  Rust does not have nulls, 
  // but it does have an enum that can encode the concept of a value being present or absent
    // This enum is Option<T>
  // Defined by Standard Library as:
/*
enum Option<T> {
    Some(T),
    None,
}
*/
let option_some_number = Some(5);
let option_some_string = Some("a string");
let option_absent_number: Option<i32> = None;
println!("OPTIONAL Key: {:?}, {:?}, {:?}", option_some_number, option_some_string, option_absent_number);
println!("MORE INFO ABOUT OPTION<T>: https://doc.rust-lang.org/std/option/enum.Option.html");

//// match control operator
// Match allows you to compare a value against a series of patterns and then execute code based on which pattern matches
  // Write a function that can take an unknown United States coin and determine which coin it is and return its value in cents
#[derive(Debug)] // so we can inspect the state in a minute
enum UsState { Alabama, Alaska, }
enum Coin { Penny, Nickel, Dime, Quarter(UsState), }
fn value_in_cents(coin: Coin) -> u8 {
  match coin {
    Coin::Penny => { println!("Lucky penny!"); 1 },
    Coin::Nickel => 5, Coin::Dime => 10,
    Coin::Quarter(state) => { println!("State quarter from {:?}!", state); 25 },
  } }
value_in_cents(Coin::Penny); value_in_cents(Coin::Nickel); value_in_cents(Coin::Dime);
value_in_cents(Coin::Quarter(UsState::Alabama)); value_in_cents(Coin::Quarter(UsState::Alaska));
//--- Matching with Option<T>
fn plus_one_option(x: Option<i32>) -> Option<i32> {
  match x {
    None => None,
    Some(i) => Some(i + 1),
  } }
let five = Some(5);
let six = plus_one_option(five);
let none = plus_one_option(None);
println!("five: {:?}, six: {:?}, none: {:?}", five, six, none);
//--- Special Pattern '_': a pattern we can use when we don’t want to list all possible values 
let some_u8_value = 0u8;
match some_u8_value {
    1 => println!("one"),
    3 => println!("three"),
    5 => println!("five"),
    7 => println!("seven"),
    _ => println!("some_u8_value OTHER: {}", some_u8_value),
}
//--- Concise Control Flow with if let
  // The if let syntax lets you combine if and let into a less verbose way to handle values
    // that match one pattern while ignoring the rest.
let if_let_some_u8_value = Some(3u8);
if let Some(3) = if_let_some_u8_value {
    println!("IF LET: three");
}
// Or we could use an if let and else expression like this:
fn count_coins(coin: Coin) {
  let mut coin_count = 0;
  if let Coin::Quarter(state) = coin { println!("IF LET ELSE: State quarter from {:?}!", state); }
      else { coin_count += 1; }
  println!("IF LET ELSE: Coin Count: {}", coin_count);
}
count_coins(Coin::Quarter(UsState::Alaska));
count_coins(Coin::Penny);
  //// end enums
  
  //// hash
    //// use std::collections::HashMap; // at top of file
let mut scores = HashMap::new();
scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);
println!("Hash scores: {:?}", scores);
  //// from vectors
let teams  = vec![String::from("Blue"), String::from("Yellow")];
let initial_scores = vec![10, 50];
let scores_vector: HashMap<_, _> = teams.iter().zip(initial_scores.iter()).collect();
println!("Hash scores_vector: {:?}", scores_vector);
  //--- Hash Ownership
let field_name = String::from("Favorite color");
let field_value = String::from("Blue");
let mut map = HashMap::new();
map.insert(field_name, field_value); // field_(name|value) are moved here
  // field_name and field_value are invalid at this point, try using them and
  // see what compiler error you get!
// println!("{},{}",field_name,field_value);
  //--- Hash Access
let mut scores_access = HashMap::new();
scores_access.insert(String::from("Blue"), 10);
scores_access.insert(String::from("Yellow"), 50);
let team_name = String::from("Blue");
let score_access = scores_access.get(&team_name); // direct
println!("HASH score_access DIRECT: {:?}", score_access);
for (key, value) in &scores { println!("HASH score_access LOOP: {}: {}", key, value); }// loop
  //--- Hash Value Overwrite
scores_access.insert(String::from("Blue"), 10);
scores_access.insert(String::from("Blue"), 25);
println!("HASH OVERWRITE values: {:?}", scores_access);
  //--- Hash Add ONLY New Values
let mut scores_new = HashMap::new();
scores_new.insert(String::from("Blue"), 10);
scores_new.entry(String::from("Yellow")).or_insert(50);
scores_new.entry(String::from("Blue")).or_insert(50);
println!("Hash Add ONLY New Values: {:?}", scores_new);
  //--- Updating based on prev val
  let text = "hello world wonderful world";
  let mut map = HashMap::new();
  for word in text.split_whitespace() {
    let count = map.entry(word).or_insert(0);
    *count += 1; // The or_insert method actually returns a mutable reference (&mut V) to the value for this key.
      // Here we store that mutable reference in the count variable, so in order to assign to that value,
        // we must first dereference count using the asterisk (*).
      // The mutable reference goes out of scope at the end of the for loop, so all of these changes are safe and allowed by the borrowing rules.
  }
println!("HASH Updating based on prev val: {:?}", map);
  //// end hash

  //// generic type
  #[derive(Debug)]
  struct Point<T, U> {
    x: T,
    y: U,
  }
  impl<T,U> Point<T, U> {
    fn x(&self) -> &T { &self.x }
    fn mixup<V, W>(self, other: Point<V, W>) -> Point<T, W>
      { Point { x: self.x, y: other.y, } }
  }
  impl Point<f32,f32> { // ONLY have this method if point is of type f32
    fn distance_from_origin(&self) -> f32 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}

fn point_generic() {
  let both_integer = Point { x: 5, y: 10 };
  let both_float = Point { x: 1.0, y: 4.0 };
  let integer_and_float = Point { x: 5, y: 4.0 };
  println!("GENERIC points: {:?}, {:?}, {:?}, {:?}", both_integer, both_float, integer_and_float, integer_and_float.x());

  let p1 = Point { x: 5, y: 10.4 };
  let p2 = Point { x: "Hello", y: 'c'};
  let p3 = p1.mixup(p2);
  println!("GENERIC MIXUP: p3.x = {}, p3.y = {}", p3.x, p3.y);

  let point_distance = Point { x:3.01, y:3.01 };
  println!("GENERIC CONCRETE type: {}", point_distance.distance_from_origin());
}
point_generic();

//--- Lifetime Generic
/* FAILS: this function's return type contains a borrowed value, but the
          signature does not say whether it is borrowed from `x` or `y`
fn longest(x: &str, y: &str) -> &str {
    if x.len() > y.len() { x }
    else { y }
} */
// To fix this error, we’ll add generic lifetime parameters that define the 
  // relationship between the references so the borrow checker can perform its analysis.
// LIFETIME ANNOTATION SYNTAX:
  /*
  Lifetime annotations have a slightly unusual syntax:
    the names of lifetime parameters must start with an apostrophe (') and are usually all lowercase and very short,
    like generic types.
    Most people use the name 'a. We place lifetime parameter annotations after the & of a reference,
    using a space to separate the annotation from the reference’s type.
    ---
    &i32        // a reference
    &'a i32     // a reference with an explicit lifetime
    &'a mut i32 // a mutable reference with an explicit lifetime
    ---
    One lifetime annotation by itself doesn’t have much meaning,
      because the annotations are meant to tell Rust how generic 
      lifetime parameters of multiple references relate to each other.
  */
// With Lifetime Annotations
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() { x }
    else { y }
}
/*
The function signature now tells Rust that for some lifetime 'a, the function takes two parameters, 
  both of which are string slices that live at least as long as lifetime 'a.
The function signature also tells Rust that the string slice returned from the function 
  will live at least as long as lifetime 'a. 
*/
fn get_longest() {
  let string1 = String::from("abcd");
  let string2 = "xyz";
  let result = longest(string1.as_str(), string2);
  println!("The longest string is {}", result);
}
get_longest();

//--- Lifetime in struct
#[derive(Debug)]
struct ImportantExcerpt<'a> { part: &'a str, }
fn lifetime_struct_example() {
    let novel = String::from("Call me Ishmael. Some years ago...");
    let first_sentence = novel.split('.')
        .next()
        .expect("Could not find a '.'");
    let i = ImportantExcerpt { part: first_sentence };
    println!("LIFETIME STRUCT: {:?}", i);
}
lifetime_struct_example();

//--- Static Lifetime
// The text of this string is stored directly in the program’s binary, which is always available.
  // Therefore, the lifetime of all string literals is 'static.
let _static_str: &'static str = "I have a static lifetime.";

/* LIFETIME DEF:
The compiler uses three rules to figure out what lifetimes references have when there aren’t explicit annotations. The first rule applies to input lifetimes, and the second and third rules apply to output lifetimes. If the compiler gets to the end of the three rules and there are still references for which it can’t figure out lifetimes, the compiler will stop with an error. These rules apply to fn definitions as well as impl blocks.
The first rule is that each parameter that is a reference gets its own lifetime parameter. In other words, a function with one parameter gets one lifetime parameter: fn foo<'a>(x: &'a i32); a function with two parameters gets two separate lifetime parameters: fn foo<'a, 'b>(x: &'a i32, y: &'b i32); and so on.
The second rule is if there is exactly one input lifetime parameter, that lifetime is assigned to all output lifetime parameters: fn foo<'a>(x: &'a i32) -> &'a i32.
The third rule is if there are multiple input lifetime parameters, but one of them is &self or &mut self because this is a method, the lifetime of self is assigned to all output lifetime parameters. This third rule makes methods much nicer to read and write because fewer symbols are necessary.
*/

//--- Generic Type Parameters, Trait Bounds, and Lifetimes Together
fn longest_with_an_announcement<'a, T>(x: &'a str, y: &'a str, ann: T) -> &'a str
    where T: Display
{
  println!("GENERIC Announcement! {}", ann);
  if x.len() > y.len() { x }
  else { y }
}
println!("GENERICS ALL together: {}", longest_with_an_announcement("okie","dokie", _static_str));

  //// end generic type

  // END Snippets

  println!("Guess the number!");
  println!("CONTINUE AT: https://doc.rust-lang.org/book/ch12-00-an-io-project.html <=======CONTINUE");
  loop {
    println!("Please input your guess.");
    // let guess = String::new(); // immutable - can't call `clear` below
    let mut guess = String::new();

    let secret_number = thread_rng().gen_range(1, 101);
      // println!("The secret number is: {}", secret_number); // DEBUG

    // The & indicates that this argument is a reference,
      // which gives you a way to let multiple parts of your code access one piece of data
      // without needing to copy that data into memory multiple times.
    // &mut guess rather than &guess to make it mutable
    io::stdin().read_line(&mut guess) 
          .expect("Failed to read line"); 

      // Switching from an expect call to a match expression is how you generally 
        // move from crashing on an error to handling the error.
    let guess: u32 = match guess.trim().parse() { // convert types => run match function inline
        Ok(num) => num,
        Err(_) => continue, // underscore is catchall value; this prevents crash - restarts loop instead
    };
    println!("You guessed: {}", guess);

    match guess.cmp(&secret_number) {
      Ordering::Less => println!("Too small!"),
      Ordering::Greater => println!("Too big!"),
      Ordering::Equal => {
        println!("You win!");
        break;
      }
    }
  }
}