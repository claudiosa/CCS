
//array ... etc

let word = "um texto qualquer"
let a_array = word.split(" ")

console.log(` the array :: ${a_array}`)
console.log(` the word :: ${word}`)
// add an element at the end
a_array.push(" at the end ")
// add an element at the begin
a_array.unshift(" at the begin ")
//remove or del the last element
a_array.pop()
//remove or del the first element
a_array.shift()


// get a range of values from somewhere in array
console.log(a_array.slice(1,2)) // 1: FIRST except ... from it up to ...

// remove one or more itens from somewhere position
console.log(a_array.splice(1,2)) // 1: first position to remove ....

// to find a position in array

let index  = a_array.indexOf('texto')
console.log(index)



console.log(a_array)




console.log('The end of code ')