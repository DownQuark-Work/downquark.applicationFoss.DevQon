#[derive(PartialEq, Debug)]
struct Shoe {
    size: u32,
    style: String,
}

// custom iterator
struct Counter { count: u32, }
impl Counter {
  fn new() -> Counter {
    Counter { count: 0 }
  }
}
impl Iterator for Counter { // add iterator trait
    type Item = u32;

    fn next(&mut self) -> Option<Self::Item> { // required method `next`
        if self.count < 5 {
            self.count += 1;
            Some(self.count)
        } else {
            None
        }
    }
}

pub fn main_iterators(){
  println!("----- ITERATORS -----");

  // iterators are lazy, meaning they have no effect until you call methods that consume the iterator
  let v1 = vec![1, 2, 3];
  let v1_iter = v1.iter(); // The iterator is stored in the v1_iter variable, and no iteration takes place at that time.
  for val in v1_iter { println!("Got: {}", val); } //  loop is called using the iterator in v1_iter, each element used in one iteration of the loop
  // All iterators implement a trait named Iterator that is defined in the standard library.
    // The definition of the trait looks like this:
  /*
  pub trait Iterator {
    type Item;
    fn next(&mut self) -> Option<Self::Item>;
    // methods with default implementations elided
  }
  */

  /*
  Other methods defined on the Iterator trait, known as iterator adaptors, 
    allow you to change iterators into different kinds of iterators. 
  You can chain multiple calls to iterator adaptors to perform complex actions in a readable way. 
  But because all iterators are lazy:
    you have to call one of the consuming adaptor methods to get results from calls to iterator adaptors.
  */
  let v1: Vec<i32> = vec![1, 2, 3];
  // v1.iter().map(|x| x + 1);
    // Above does nothing: iterators are lazy and do nothing unless consumed,
      // the closure we’ve specified never gets called.
    // To fix this and consume the iterator, we’ll use the collect method
  let v2: Vec<_> = v1.iter().map(|x| x + 1).collect();
  assert_eq!(v2, vec![2, 3, 4]);

  // Common use of closures that capture their environment by using the filter iterator adaptor
    let shoes = vec![
      Shoe {
        size: 10,
        style: String::from("sneaker"),
      },
      Shoe {
        size: 13,
        style: String::from("sandal"),
      },
      Shoe {
        size: 10,
        style: String::from("boot"),
      },
    ];
    let in_my_size = shoes_in_my_size(shoes, 10);
    println!("in_my_size: {:?}",in_my_size);

    create_custom_iterator();
}

fn create_custom_iterator()
{
  /*
  https://doc.rust-lang.org/book/ch13-02-iterators.html#creating-our-own-iterators-with-the-iterator-trait
    Can also create iterators that do anything you want by implementing the Iterator trait on your own types
    Only method you’re required to provide a definition for is the `next` method
    After you can use all other methods that have default implementations provided by the Iterator trait
  */
  //Create an iterator that will only ever count from 1 to 5

  println!("Create `Counter` Struct for Custom Iterator"); // top of file
  println!("`cargo test` to verify working");
  let mut counter = Counter::new();
  counter.next();
}

fn shoes_in_my_size(shoes: Vec<Shoe>, shoe_size: u32) -> Vec<Shoe> {
    shoes.into_iter().filter(|s| s.size == shoe_size).collect()
}

#[cfg(test)]
mod tests {
  use super::*;

#[test]
  fn iterator_demonstration() {
    let v1 = vec![1, 2, 3];
    let mut v1_iter = v1.iter();
    assert_eq!(v1_iter.next(), Some(&1));
    assert_eq!(v1_iter.next(), Some(&2));
    assert_eq!(v1_iter.next(), Some(&3));
    assert_eq!(v1_iter.next(), None);
    /*
      *NOTE: that we needed to make v1_iter mutable: 
        calling the next method on an iterator changes internal state
        that the iterator uses to keep track of where it is in the sequence. 
      The code consumes, or uses up, the iterator
      In `main_iterators` we didn’t need to make v1_iter mutable when we used a for loop
        because the loop took ownership of v1_iter and made it mutable behind the scenes.
    */
    /*
    *NOTE: values received from `next` calls are immutable references to the values in the vector.
      The iter method produces an iterator over immutable references.
    If we want to create an iterator that takes ownership of v1 and returns owned values,
      we can call into_iter instead of iter.
    Similarly, if we want to iterate over mutable references,
      we can call iter_mut instead of iter.
    */
  }
  #[test]
  fn iterator_sum() {
    // Methods that call next are called consuming adaptors, because calling them uses up the iterator.
    // One example is the sum method, which takes ownership of the iterator
      // and iterates through the items by repeatedly calling next
    let v1 = vec![1, 2, 3];
    let v1_iter = v1.iter();
    let total: i32 = v1_iter.sum();
    assert_eq!(total, 6);
    // We aren’t allowed to use v1_iter after the call to sum because 
      // sum takes ownership of the iterator we call it on.
  }
  #[test]
  fn filters_by_size() {
    // Common use of closures that capture their environment by using the filter iterator adaptor
    let shoes = vec![
      Shoe {
        size: 10,
        style: String::from("sneaker"),
      },
      Shoe {
        size: 13,
        style: String::from("sandal"),
      },
      Shoe {
        size: 10,
        style: String::from("boot"),
      },
    ];
    let in_my_size = shoes_in_my_size(shoes, 10);
    assert_eq!(
      in_my_size,
      vec![
        Shoe {
          size: 10,
          style: String::from("sneaker")
        },
        Shoe {
          size: 10,
          style: String::from("boot")
        },
      ]
    );
  }

  #[test]
  fn calling_next_directly() {
    let mut counter = Counter::new();

    assert_eq!(counter.next(), Some(1));
    assert_eq!(counter.next(), Some(2));
    assert_eq!(counter.next(), Some(3));
    assert_eq!(counter.next(), Some(4));
    assert_eq!(counter.next(), Some(5));
    assert_eq!(counter.next(), None);
  }
  #[test]
  fn using_other_iterator_trait_methods() {
    println!("Using Other CUSTOM Iterator Trait Methods");
    /*
    We implemented the Iterator trait by defining the next method,
      so we can now use any Iterator trait method’s default implementations as defined in the standard library,
      because they all use the next method’s functionality.
    RANDOM:: Take the values produced by an instance of Counter,
      pair them with values produced by another Counter instance after skipping the first value,
      multiply each pair together, keep only those results that are divisible by 3,
      and add all the resulting values together
    */
    let sum: u32 = Counter::new()
      .zip(Counter::new().skip(1))
      .map(|(a, b)| a * b)
      .filter(|x| x % 3 == 0)
      .sum();
    assert_eq!(18, sum);
  }
}