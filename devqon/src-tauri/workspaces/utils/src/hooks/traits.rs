use super::enumerate;
pub fn traits(){
  println!("TODO: hooks");
  println!("ApplicationFlowState: {:?}", enumerate::Hooks::Flow(enumerate::ApplicationFlowState::LAUNCH));
}

// trait TriggerImpl = {
//   fn trigger_hook(&self) -> string;
// }

// impl TriggerImpl for Hook {
//   fn trigger_hook(&self) -> string {
//       "TRIGGERED"
//   }
// }