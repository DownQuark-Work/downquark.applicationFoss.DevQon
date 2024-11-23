use particle_flows::particles::symbols::structs::_downquark::StateApplicationInitialization;
use std::sync::Mutex;

pub fn get_setup_state() -> Mutex<StateApplicationInitialization> {
    Mutex::new(StateApplicationInitialization {
        frontend_task: false,
        backend_task: false,
    })
}
