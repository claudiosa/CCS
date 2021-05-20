const an_interval = 3000
const checking_F = () => {
        console.log('checking .... !!!')
        }


// checking_F is a callback function, called after 3000 mseg
// or an_interval
setInterval(checking_F, an_interval)

console.log("The begining ... \nAn asyncronous process:")