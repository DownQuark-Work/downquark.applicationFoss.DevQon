use tauri::Manager;

use crate::helpers::build::handle_authorization_state;
use crate::helpers::state::_devqon::UserSession;


#[tauri::command]
pub fn cmd_authenticate_user(auth_type:&str, credential_primary:&str, credential_secondary:&str, app_handle: tauri::AppHandle,) -> Option<String> {
  // there would be a persist check here to update (at least the) session in the db.
  //  &&|| login/register a new user
  println!("MOCK DB AUTHENTICATION CALL.:{}:. {} -- {}!", auth_type,credential_primary,credential_secondary);
  let return_payload = app_handle.state::<UserSession>().id.clone()+"~!~"+&app_handle.state::<UserSession>().session_id;
  handle_authorization_state(&app_handle);
  Some(return_payload)
}