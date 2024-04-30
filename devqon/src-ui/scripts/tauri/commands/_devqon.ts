// https://beta.tauri.app/guides/upgrade-migrate/from-tauri-1/#javascript-api-changes
import { invoke } from "@tauri-apps/api/core";

import type {InitResultType,InvokeCommandsListType} from '../../types/devqon.d.ts'

const autoInvokeCommonCommandsList = [
  {
    name:'cmd_two_way_comm',
    opts:{ number: Date.now(), },
    cb:(res:InitResultType) => console.log(`Message: ${res.message}, Other Val: ${res.other_val}`),
  },
]

export const _invokeCommands = (commandsList:InvokeCommandsListType) => {
  commandsList.forEach(command => {
    console.log('command: ', command)
    invoke(command.name,command.opts)
      .then(command.cb as any).catch((e) => console.error(e))
  })
}

_invokeCommands(autoInvokeCommonCommandsList) // will be run on all screens

/** DEBUG webview reference
import { getAll,getCurrent } from "@tauri-apps/api/webview";
import { Webview } from '@tauri-apps/api/webview';
const debugInfo = async () => {
  const currentWebView = await getCurrent() // ensures splashscreen is active
        // currentWebView.setFocus() // with correct permissions
  // const loadedIt = await currentWebView.listen("on-validations-complete", ({ event, payload }) => { 
  console.log('getAll: ', ...getAll())
  
  const mainWebview = Webview.getByLabel('main')
  console.log('mainWebView: ', {mainWebview})
  // const loadedIt = await mainWebview?.listen("on-validations-complete", ({ event, payload }) => { 
  // await getCurrent().reparent('main');

  const curCurrent = await getCurrent()
  console.log('curCurrent: ', curCurrent)
  curCurrent.setFocus()
  const loadedIt = await curCurrent.listen("on-validations-complete", ({ event, payload }) => { 
    console.log('event,payload: ', event,payload)
  });
  loadedIt && console.log('loadedIt(): ', loadedIt()) // unlisten
}
*/
