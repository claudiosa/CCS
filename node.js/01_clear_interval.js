const a_duration = 1000
const checking_F = () => {
        console.log('checking .... !!!')
        }


// checking_F is a callback function, called after 3000 mseg
// or an_interval
let an_interval = setInterval(checking_F,  a_duration)

//clearTimeout(an_interval) // it cancels this interval
setTimeout( () => clearInterval(an_interval), 3000)
//setTimeout_F( () => clearTimeout(an_interval))

console.log("The begining ... \nAn asyncronous process:")