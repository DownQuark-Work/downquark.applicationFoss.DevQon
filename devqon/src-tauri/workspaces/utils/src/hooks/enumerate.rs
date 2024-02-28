#[derive(Debug)]
pub enum FlowInitialize { BEGIN, // splash screen shown
  DqDirExists, DqDirDoesNotExist, // first check - any dq desktop product could create this
  DevQonDirExists, DevQonDirDoesNotExist, // second check - only devqon could create this
  DevQonActiveVisionexists, DevQonActiveVisionDoesNotExist, // third check - active view saved from previous session
  END, // splash screen removed
}
#[derive(Debug)]
pub enum FlowView {
  INSTALL, // DqDirDOES_NOT_EXIST
  FirstRun, // DEVQON_DIR_DOES_NOT_EXIST
  VisionActive, // DEVQON_ACTIVE_VISION_EXISTS
  VisionInactive, // DEVQON_ACTIVE_VISION_DOES_NOT_EXIST
}
#[derive(Debug)]
pub enum ApplicationFlowState { // TODO: convert to FSM
  LAUNCH, // startup,
  PROCESSING, // useful for heavy calculations
  INITIALIZE(FlowInitialize),
  VIEW(FlowView),
  EXIT, // shutdown
}

#[derive(Debug)]
pub enum ApplicationEventType {DISPATCH,LISTEN,}

#[derive(Debug)]
pub enum Hooks {
  Events(ApplicationEventType),
  Flow(ApplicationFlowState),
}

// pub enum Hook {
//   ApplicationEvent,
//   ApplicationFlow,
// }
// impl Hook {
//   fn get_hooks(&self) -> ApplicationFlowState {
//     match self {
//       Self::ApplicationFlow => ApplicationFlowState,
//     }
//   }
//   fn when_event(&self) -> ApplicationEventType {
//     match self { // stub for now
//       Self::ApplicationEvent => ApplicationEventType,
//     }
//   }
// }