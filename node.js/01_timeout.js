const timeOut = 3000
const finished_F = () => {
        console.log('finished !!!')
        console.log('time over !!!')
        }


// finished_F is a callback function, called after 3000 mseg
//
setTimeout(finished_F, timeOut)

console.log("the begining ... assyncoronous process")