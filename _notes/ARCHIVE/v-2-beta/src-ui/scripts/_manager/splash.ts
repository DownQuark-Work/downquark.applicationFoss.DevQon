import { evtInitializeBuildAndValidation } from "../tauri/events/splash";
import { invokeSplashScreenCommands } from "../tauri/commands/splash";
import { Cookie } from "../_utils/cookie";
import { DEVQON } from "../_utils/constants";

import type { SplashScreenBuildValidationPayloadType } from "../types/devqon";

const determineUserCookies = () => {
  const User = {
    Session:Cookie.GET(DEVQON.COOKIE.USER.SESSION),
    UUID:Cookie.GET(DEVQON.COOKIE.USER.UUID),
    hasInfo:false,
  }
  User.hasInfo = !!(User.Session.length+User.UUID.length)
  return User
}

const setLocalSession = (sessionValues:string) => {
  // again - pseudo implementation here. Do not do this.
  const [uuid,sessionId] = sessionValues.split('~!~')
  Cookie.SET(DEVQON.COOKIE.USER.SESSION,sessionId)
  Cookie.SET(DEVQON.COOKIE.USER.UUID,uuid)
}

const authenticateUser = (type:string,opts:{[k:string]:string}) => {
  const authTypes = DEVQON.AUTH.TYPE
  // stub for now ... handle real implementation on case by case basis
  switch(type) {
    case authTypes.NEW_VALIDATION.LOGIN:
    case authTypes.NEW_VALIDATION.REGISTER:
      invokeSplashScreenCommands('ON_AUTH',{0:{authType:type,credentialPrimary:opts.email,credentialSecondary:opts.password, cb:setLocalSession}})
      return
    case authTypes.PREVIOUS_VALIDATION.COOKIE:
      case authTypes.PREVIOUS_VALIDATION.DATABASE:
      invokeSplashScreenCommands('ON_AUTH',{0:{authType:type,credentialPrimary:opts.session,credentialSecondary:opts.user_id, cb:setLocalSession}})
      return
    default:
      throw new Error('No valid authorization')
  }
}

const handleUserAuthentication = (validations:SplashScreenBuildValidationPayloadType) => {
  // stub for now ... handle real implementation on case by case basis
  // info from db takes priority
  const validationPayload = validations.payload
  if(validationPayload.usr_uuid) {
    const {usr_uuid:user_id,session_exists:session} = validationPayload
    return authenticateUser(DEVQON.AUTH.TYPE.PREVIOUS_VALIDATION.DATABASE,{session:session?'SESSION_EXISTS':'',user_id,})
  }

  // then local storage if available
  const userCookies = determineUserCookies()
  if(userCookies.hasInfo)
    return authenticateUser(DEVQON.AUTH.TYPE.PREVIOUS_VALIDATION.COOKIE,{session:userCookies.Session,user_id:userCookies.UUID,})
  
  // if none, allow login/register
  const btns = document.querySelectorAll('button[type="button"')
  btns.forEach(btn => {
    btn.addEventListener('click', _=>{
      authenticateUser(DEVQON.AUTH.TYPE.NEW_VALIDATION.LOGIN,{email:'make@this.work',password:'when_the_time_is_right'}) // TODO: make register separate, non-stubbed, function
    })
  })
}

export const initializeSplashScreen = async () => {
  evtInitializeBuildAndValidation(handleUserAuthentication)
  invokeSplashScreenCommands('ON_BUILD')
}

