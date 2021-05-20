const timeOut = 3000
const finished_F = () => {
        console.log('finished !!!')
        console.log('time over !!!')
        }


// finished_F is a callback function, called after 3000 mseg
//
//console.log(setTimeout(finished_F, timeOut))
let a_timer = setTimeout(finished_F, timeOut)
clearTimeout(a_timer)// cancell the timer previously defined
console.log("the begining ... \n an asyncronous process")