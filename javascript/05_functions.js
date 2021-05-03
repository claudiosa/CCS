//A callback is a function passed as an argument to another function.
/*
Using a callback, you could call the calculator function (myCalculator)
 with a callback, and let the calculator function run the callback after
  the calculation is finished:
*/
function myDisplayer(some) {
  document.getElementById("bagaça_de_um_ID").innerHTML = some;
}

function myCalculator(num1, num2, myCallback) {
  let sum = num1 + num2;
  myCallback(sum);
}

// main call
myCalculator(15, 17, myDisplayer);
/*
In the example above, myDisplayer is the name of a function.
It is passed to myCalculator() as an argument.
*/
console.log('The end of code ')