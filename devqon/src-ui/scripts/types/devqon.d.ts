export type InvokeCommandsListType = {
  name: string
  opts?: {[k:string]:any} // Record<String,any>
  cb?: Function
}[]

export type InitResultType = {
  message:string,
  other_val:string
}

export type SplashScreenBuildValidationPayloadType = {
  event: "on-validations-complete"
  id: number
  payload: {init_view: string, session_exists: boolean, update_available: boolean, usr_uuid: string}
}