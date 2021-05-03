
// escopo

let x = 'xxxxxx'

function escopo()
    {
        x = 'yyyyyy'
        return(x)
    }

//console.log(x)

//console.log(escopo())    
console.log(` Before of the function ${x} `)
console.log(` In the  function ${escopo()}`)
console.log(` After of the function ${x} `)


console.log(' the end of code ')