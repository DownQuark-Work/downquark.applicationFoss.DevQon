use particle_flows::particles::symbols::structs::_downquark::SetupState;
use std::sync::Mutex;

pub fn get_setup_state() -> Mutex<SetupState> {
    Mutex::new(SetupState {
        frontend_task: false,
        backend_task: false,
    })
}
