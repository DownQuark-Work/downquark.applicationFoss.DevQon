// to be used with `#[tauri::command]`
pub mod _devqon;

mod command {}

// I think below is close to working
// https://users.rust-lang.org/t/puzzling-expected-fn-pointer-found-fn-item/46423/9
//
//   use crate::helpers::commands::_devqon;
//   use tauri::command as tauri_command;

//   struct SplashScreen {
//     ss: String
//   }
//   pub struct CommandsByType {
//     splash_screen:SplashScreen
//   }

//   pub fn get_all_commands()->Result<CommandsByType, CommandsByType>{
//     let splash_command = _devqon::splash_screen_setup_complete
//     let splash_screen_fncs:Vec<fn()->String>  = vec![];
    
//     Ok(CommandsByType {
//       splash_screen: SplashScreen {
//         // ss: _devqon::splash_screen_setup_complete
//         ss: "test".to_string()
//       }
//     })
//   }
// }

// pub fn get_commands()->Result<command::CommandsByType, command::CommandsByType>{
//   command::get_all_commands()
// }