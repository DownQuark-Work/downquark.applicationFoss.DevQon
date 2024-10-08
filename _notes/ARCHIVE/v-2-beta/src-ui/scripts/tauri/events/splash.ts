import { listen,once } from '@tauri-apps/api/event'

// emits the `click` event with the object payload
// emit('click', {
//   theMessage: 'Tauri is awesome!',
// })

let onValidationsComplete:Function
export const evtInitializeBuildAndValidation = async (nxt:Function) => {
  console.log('zxc! - listenting initialization file')
    onValidationsComplete = await listen<string>('on-validations-complete', (event) => {
      console.log(`onValidationsComplete: `, event)
      nxt(event)
    });
    // you need to call unlisten if your handler goes out of scope e.g. the component is unmounted
    // onValidationsComplete() // remove listener
}
export const evtUnlistenInitializeBuildAndValidation = () => {
  onValidationsComplete && onValidationsComplete()
}

// const currentWebView = await getCurrent() // ensures splashscreen is active
//         currentWebView.setFocus() // with correct permissions
//   const loadedIt = await currentWebView.listen("on-validations-complete", ({ event, payload }) => { 
//     console.log('event,payload: ', event,payload)
//   });
//   loadedIt && console.log('loadedIt(): ', loadedIt()) // unlisten