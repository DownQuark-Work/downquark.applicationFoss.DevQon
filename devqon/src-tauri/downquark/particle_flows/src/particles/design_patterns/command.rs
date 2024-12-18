pub trait Migration {
  fn execute(&self) -> &str;
  fn rollback(&self) -> &str;
}

pub struct CreateTable;
impl Migration for CreateTable {
  fn execute(&self) -> &str {
    "create table"
  }
  fn rollback(&self) -> &str {
    "drop table"
  }
}

pub struct AddField;
impl Migration for AddField {
  fn execute(&self) -> &str {
    "add field"
  }
  fn rollback(&self) -> &str {
    "remove field"
  }
}

struct Schema {
  commands: Vec<Box<dyn Migration>>,
}

impl Schema {
  fn new() -> Self {
    Self { commands: vec![] }
  }

  fn add_migration(&mut self, cmd: Box<dyn Migration>) {
    self.commands.push(cmd);
  }

  fn execute(&self) -> Vec<&str> {
    self.commands.iter().map(|cmd| cmd.execute()).collect()
  }
  fn rollback(&self) -> Vec<&str> {
    self.commands
      .iter()
      .rev() // reverse iterator's direction
      .map(|cmd| cmd.rollback())
      .collect()
  }
}

pub fn main() {
  let mut schema = Schema::new();

  let cmd = Box::new(CreateTable);
  schema.add_migration(cmd);
  let cmd = Box::new(AddField);
  schema.add_migration(cmd);

  assert_eq!(vec!["create table", "add field"], schema.execute());
  assert_eq!(vec!["remove field", "drop table"], schema.rollback());
}

//trait Command {
//  fn execute(&self);
//}
//
//struct MacroCommand {
//  stack: Vec<Box<dyn Command>>,
//}
//
//impl MacroCommand {
//  fn new() -> MacroCommand {
//    MacroCommand {
//      stack: Vec::new(),
//    }
//  }
//
//  fn append(&mut self, cmd: Box<dyn Command>) {
//    self.stack.push(cmd);
//  }
//
//  fn undo(&mut self) {
//    self.stack.pop();
//  }
//
//  fn clear(&mut self) {
//    self.stack.clear();
//  }
//}
//
//impl Command for MacroCommand {
//  fn execute(&self) {
//    for command in &self.stack {
//      command.execute();
//    }
//  }
//}