use std::{env, process};
  // bring the code we moved to src/lib.rs into the scope of the binary crate
use minigrep::Config; // minigrep from Cargo.toml

// NOTE: eprintln! keeps errors out of output files:
  // `$ CASE_INSENSITIVE=1 cargo run search file.ext > output.txt`

fn main()
{
  println!(""); println!(""); println!(""); println!("."); println!("..::");
  println!("NOTE: View '.bak' files for annotations and notes");
  println!("CONTINUE:: https://doc.rust-lang.org/book/ch12-05-working-with-environment-variables.html");
  println!("..::"); println!("."); println!(""); println!(""); println!("");

  let args: Vec<String> = env::args().collect();
  println!("{:?}", args);
  
    // Below is inefficient cloning
  // let config = Config::new(&args).unwrap_or_else(|err| {
  //   eprintln!("Problem parsing arguments: {}", err);
  //   process::exit(1);
  // });
    // Can use iterator instead
  let config = Config::new(env::args()).unwrap_or_else(|err| {
    eprintln!("Problem parsing arguments: {}", err);
    process::exit(1);
  });
  println!("Searching for {}", config.query);
  println!("In file {}", config.filename);

  if let Err(e) = minigrep::run(config) // scope to run function
  {
    eprintln!("Application error: {}", e);
    process::exit(1);
  }
}
