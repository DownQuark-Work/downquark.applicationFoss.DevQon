# [rust interactive book](https://rust-book.cs.brown.edu/)
## Cargo
https://doc.rust-lang.org/cargo/guide/creating-a-new-project.html <-- create new
  - [manifest fmt](https://doc.rust-lang.org/cargo/reference/manifest.html)
  - [toml cnf](https://doc.rust-lang.org/cargo/reference/config.html)
- [commands](https://doc.rust-lang.org/cargo/commands/index.html)
- [faq](https://doc.rust-lang.org/cargo/faq.html)
- `% cargo tree`

https://play.rust-lang.org/?version=stable&mode=debug&edition=2021
https://doc.rust-lang.org/stable/rust-by-example/trait.html
https://doc.rust-lang.org/stable/rust-by-example/scope/lifetime.html
https://doc.rust-lang.org/stable/rust-by-example/macros.html

std ref:: https://doc.rust-lang.org/stable/rust-by-example/std.html
unsafe:: https://doc.rust-lang.org/stable/rust-by-example/unsafe.html

testing ref:: https://doc.rust-lang.org/stable/rust-by-example/testing.html
`#[derive(Debug)]` // allows :? to be used in println! below
`#[cfg(test)]` // allows assertions via `#[test]` eg:
```rust
 #[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(1, 2), 3);
    }

    #[test]
    fn test_bad_add() {
        // This assert would fire and test will fail.
        // Please note, that private functions can be tested too!
        assert_eq!(bad_add(1, 2), 3);
    }

    #[test]
    #[should_panic]
    fn test_any_panic() {
        divide_non_zero_result(1, 0);
    }

    #[test]
    #[should_panic(expected = "Divide result is zero")]
    fn test_specific_panic() {
        divide_non_zero_result(1, 10);
    }
}
```

## [crates](https://doc.rust-lang.org/book/ch07-01-packages-and-crates.html)
A _crate_ is the smallest amount of code that the Rust compiler considers at a time.

A crate can come in one of two forms: a **binary** crate or a **library** crate.

1. _**Binary**_ crates are programs you can compile to an executable that you can run, such as a command-line program or a server.
    - Each must have a function called `main` that defines what happens when the executable runs.

1. _**Library**_ crates don’t have a main function, and they don’t compile to an executable.
    - Instead, they define functionality intended to be shared with multiple projects.

## library
### create
`% rustc --crate-type=lib rary.rs`
_OR_ add to top of file:
```
// This crate is a library
#![crate_type = "lib"]
// The library is named "rary"
#![crate_name = "rary"]
```
then flags unneeded
`% rustc lib.rs`

### use
use rustc's `--extern` flag.
```
# Where library.rlib is the path to the compiled library, assumed that it's
# in the same directory here:
$ rustc executable.rs --extern rary=library.rlib && ./executable 
```

## cargo
package code with `lib`s

Create a new Rust project:
```
# A binary
cargo new foo

# A library
cargo new --lib bar
```
results in:
```
.
├── bar
│   ├── Cargo.toml
│   └── src
│       └── lib.rs
└── foo
    ├── Cargo.toml
    └── src
        └── main.rs

```
Add deps to `Cargo.toml`

```
[package]
name = "foo"
version = "0.1.0"
authors = ["mark"]

[dependencies]
clap = "2.27.1" # from crates.io
rand = { git = "https://github.com/rust-lang-nursery/rand" } # from online repo
bar = { path = "../bar" } # from a path in the local filesystem
```

Then make it work with:
> To build our project we can execute cargo build anywhere in the project directory (including subdirectories!). We can also do cargo run to build and run. Notice that these commands will resolve all dependencies, download crates if needed, and build everything, including your crate. (Note that it only rebuilds what it has not already built, similar to make).

### with tests
organize like below:
```
foo
├── Cargo.toml
├── src
│   └── main.rs
│   └── lib.rs
└── tests
    ├── my_test.rs
    └── my_other_test.rs
```
then `% cargo test`

### pre-reqs
e.g. a **build script** - in _Cargo.toml_
```
[package]
...
build = "build.rs"
```


## reference 
https://doc.rust-lang.org/reference/patterns.html
https://doc.rust-lang.org/src/core/macros/mod.rs.html <-- search for 'pub macro'