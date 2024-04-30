import { _invokeCommands } from "./_devqon"

import type { InvokeCommandsListType } from "../../types/devqon"

const splashScreenCommands:Record<string,InvokeCommandsListType> = {
  ON_AUTH:[
    { name:'cmd_authenticate_user',
      opts:{ authType:'', credentialPrimary: '', credentialSecondary:'', },
      cb:(res:string) => console.log(`Authenticated: ${res}`), },
  ],
  ON_BUILD:[
      { name:'cmd_initialize_build',
      // opts:{ name: 'DevQon' },
      // cb:() => console.log('do next'),
      },
    ],
}

export const invokeSplashScreenCommands = async (type:string,opts?:Record<number,any>) => {
  // usage: `invokeSplashScreenCommands('ON_BUILD',{0:{name:'new name',cb:()=>console.log('yo yo')}})`
  const invkCmnds = splashScreenCommands[type]
  opts && Object.entries(opts).forEach(indexVal => {
    const i = parseInt(indexVal[0],10)
    invkCmnds[i].opts = {...invkCmnds[i].opts, ...indexVal[1]}
    if(indexVal[1]?.cb) { // overwrite the callback if required
      invkCmnds[i].cb = indexVal[1].cb
      delete invkCmnds[i]?.opts?.cb
    }
  })
  _invokeCommands(invkCmnds)
}