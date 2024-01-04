// use std::collections::HashMap;
use std::thread;
use std::time::Duration;

struct Cacher<T>
where
    T: Fn(u32) -> u32,
{
    calculation: T,
    // hash_value: HashMap<u32, u32>,
    value: Option<u32>,
}

impl<T> Cacher<T>
where
    T: Fn(u32) -> u32,
{
  // 2 problems with Cacher that would make reusing it in different contexts difficult.
    // 1.Cacher assumes it will always get the same value for the parameter arg to the value method
      /* FAILS:
        let mut c = Cacher::new(|a| a);
        let v1 = c.value(1);
        let v2 = c.value(2);
        assert_eq!(v2, 2);
      */
      // To fix: hold a hash map rather than a single value.
    // 2.Only accepts closures that take one parameter of type u32 and return a u32
      // To fix: use more generic parameters to increase flexibility

    fn new(calculation: T) -> Cacher<T> {
        Cacher {
          calculation,
          // hash_value: HashMap::new(),
          value: None,
        }
    }
    // BELOW IS CLOSE
    /* fn hash_value(&mut self, _arg: u32) -> u32 {
    //   match self.hash_value[&_arg] {
    //     Some(v) => self.hash_value,
    //     None => {
    //       let v = (self.calculation)(_arg);
    //       self.hash_value.insert(_arg, v)
    //     }
    //   }
    } */
    fn value(&mut self, arg: u32) -> u32 {
        match self.value {
            Some(v) => v, // responsible for memoization [if exists, return this]
            None => { // if dne, set and return
                let v = (self.calculation)(arg);
                self.value = Some(v);
                v
            }
        }
    }
}

/// Also Allowable on functions
/// (or anything else)
/// # Examples
///
/// ```
/// functional::closures::main_closures();
/// ```

pub fn main_closures()
{
  println!("----- CLOSURES -----");
  let simulated_user_specified_value = 10;
  let simulated_random_number = 7;

  // nondry_generate_workout(simulated_user_specified_value, simulated_random_number);
  // dry_generate_workout(simulated_user_specified_value, simulated_random_number);
  non_memoized_closure_generate_workout(simulated_user_specified_value, simulated_random_number);
  memoized_closure_generate_workout(simulated_user_specified_value, simulated_random_number);

  // Capturing the Environment with Closures
    // https://doc.rust-lang.org/book/ch13-01-closures.html#capturing-the-environment-with-closures
  /*
    `x` is not one of the parameters of equal_to_x,
      equal_to_x closure is allowed to use the x variable that’s 
      defined in the same scope that equal_to_x is defined in.
  */
  let x = 4;
  let equal_to_x = |z| z == x;
  //  fn equal_to_x(z: i32) -> bool { z == x } // function would fail with: can't capture dynamic environment in a fn item
  let y = 4;
  assert!(equal_to_x(y));
  /*
  When a closure captures a value from its environment, it uses memory to store the values for use in the closure body.
  Because functions are never allowed to capture their environment, defining and using functions will never incur this overhead.

  When you create a closure, Rust infers which trait to use based on how the closure uses the values from the environment.
  Closures can capture values from their environment in three ways, which directly map to the three ways a function can take a parameter: taking ownership, borrowing mutably, and borrowing immutably. These are encoded in the three Fn traits as follows:
    - FnOnce consumes the variables it captures from its enclosing scope (closure’s environment).
        The closure takes ownership of the variables and moves them into the closure when it is defined.
        The closure can’t take ownership of the same variables more than once, so it can be called only once.
    - FnMut can change the environment because it mutably borrows values.
    - Fn borrows values from the environment immutably.
  All closures implement FnOnce because they can all be called at least once.
  Closures that don’t move the captured variables also implement FnMut
  Closures that don’t need mutable access to the captured variables also implement Fn
  */
}

/*
fn simulated_expensive_calculation(intensity: u32) -> u32 {
  println!("calculating slowly...");
  thread::sleep(Duration::from_secs(2));
  intensity
}

fn nondry_generate_workout(intensity: u32, random_number: u32) {
  if intensity < 25 {
    println!(
      "Today, do {} pushups!",
      simulated_expensive_calculation(intensity)
    );
    println!(
      "Next, do {} situps!",
      simulated_expensive_calculation(intensity)
    );
} else {
  if random_number == 3 {
    println!("Take a break today! Remember to stay hydrated!");
  } else {
    println!(
      "Today, run for {} minutes!",
      simulated_expensive_calculation(intensity)
    );
    }
  }
}

fn dry_generate_workout(intensity: u32, random_number: u32) {
    let expensive_result = simulated_expensive_calculation(intensity);

    if intensity < 25 {
        println!("Today, do {} pushups!", expensive_result);
        println!("Next, do {} situps!", expensive_result);
    } else {
        if random_number == 3 {
            println!("Take a break today! Remember to stay hydrated!");
        } else {
            println!("Today, run for {} minutes!", expensive_result);
        }
    }
}
*/

fn non_memoized_closure_generate_workout(intensity: u32, random_number: u32) {
  /*
  To define a closure, we start with a pair of vertical pipes (|), 
    //inside which we specify the parameters to the closure; 
    // this syntax was chosen because of its similarity to closure definitions in Smalltalk and Ruby. 
  // This closure has one parameter named num: if we had more than one parameter,
    // we would separate them with commas, e.g:
      // |param1, param2|
  */
  /*
    Type annotations are required on functions because they’re part of an explicit interface exposed to your users.
      Defining this interface rigidly is important for ensuring that everyone agrees on what types of values a
      function uses and returns
    Making programmers annotate the types in these small, anonymous functions would be annoying and largely redundant
    We can add type annotations if we want to increase explicitness and clarity at the cost of
      being more verbose than is strictly necessary
      e.g:
        `let expensive_closure = |num: u32| -> u32 {`
    All The Below are equivalent
    ```
    fn  add_one_v1   (x: u32) -> u32 { x + 1 }
    let add_one_v2 = |x: u32| -> u32 { x + 1 };
    let add_one_v3 = |x|             { x + 1 };
    let add_one_v4 = |x|               x + 1  ; <-- notice semi-colon - NOT returning closure so it is needed
    ```
    Breaking: Attempting to call a closure whose types are inferred with two different types
    ```
    let example_closure = |x| x;
    let s = example_closure(String::from("hello"));
    let n = example_closure(5);
    ```
  */
  let expensive_closure = |num| { // akin to javascript: The end of the closure, after the curly brackets, needs a semicolon to complete the let statement
    println!("[NON-MEMOIZED] calculating slowly...");
    thread::sleep(Duration::from_secs(2));
    num
  };

  if intensity < 25 { // Calling the closure will make the user wait 2x as long
    println!("Today, do {} pushups!", expensive_closure(intensity));
    println!("Next, do {} situps!", expensive_closure(intensity));
    // One option to solve this issue is to save the result of the expensive closure in a variable
      // for reuse and use the variable in each place we need the result, instead of calling the closure again.
    // However, this method could result in a lot of repeated code.
    // Another solution is available to us. (memoization)
      // Create a struct that will hold the closure and the resulting value of calling the closure
      // All closures implement at least one of the traits: Fn, FnMut, or FnOnce
        // https://doc.rust-lang.org/book/ch13-01-closures.html#capturing-the-environment-with-closures
      // *NOTE: Functions can implement all three of the Fn traits too
  } else {
    if random_number == 3 {
      println!("Take a break today! Remember to stay hydrated!");
    } else {
      println!(
        "Today, run for {} minutes!",
        expensive_closure(intensity)
      );
    }
  }
}

fn memoized_closure_generate_workout(intensity: u32, random_number: u32) {
  let mut expensive_result = Cacher::new(|num| {
    println!("[MEMOIZED] calculating slowly...");
    thread::sleep(Duration::from_secs(2));
    num
  });

  if intensity < 25 {
    println!("Today, do {} pushups!", expensive_result.value(intensity));
    println!("Next, do {} situps!", expensive_result.value(intensity));
  } else {
    if random_number == 3 {
        println!("Take a break today! Remember to stay hydrated!");
    } else {
      println!(
        "Today, run for {} minutes!",
        expensive_result.value(intensity)
      );
    }
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn call_with_different_values() {
    let mut c = Cacher::new(|a| a);
    let _v1 = c.value(1); // underscore vars unused on purpose
    let v2 = c.value(2);
    assert_eq!(v2, 1); // <-- Would expect to be 2 - finish hash mapping to fix
  }
}