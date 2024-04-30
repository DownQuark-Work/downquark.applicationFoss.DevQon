const deleteCookie = (name?:string)  => {
  if(name){
    document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/"
    return
  }
  const allCookies = decodeURIComponent(document.cookie).split('; ')
  allCookies.forEach(cook => {
    const curCook = cook.split('=')[0]
    document.cookie = curCook + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/"
  })

}
const getCookies = (name?:string) => {
  if(!name) return document.cookie
  const k = name + "=",
        decoded = decodeURIComponent(document.cookie).split('; ')
      return decoded.filter(cName => cName.indexOf(k)===0)[0]?.substring(k.length)||''
}
const setCookie = (name:string,value:string,expireInDays:number=365) => {
  const date = new Date()
  date.setTime(date.getTime() + (expireInDays * 24 * 60 * 60 * 1000))
  const expires = "expires=" + date.toUTCString()
  document.cookie = name + "=" + value + "; " + expires + "; path=/"
}

export const Cookie = {
  DELETE:deleteCookie,
  GET:getCookies,
  SET:setCookie,
  UPDATE:setCookie,
}