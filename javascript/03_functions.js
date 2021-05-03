// HOISTING ....
// a = 100
b = 200

//To avoid this pitfall, we would make sure to declare and initialise the variable before we use it:

function hoist_2() {
    var message='Hoisting is all the rage!'
    return (message);
  }


function hoist_1() {
    a = 20;
    var b = 100;
  }
  
  hoist_1();
  
  console.log(hoist_2()); // Ouput: Hoisting is all the rage!

  console.log(a);
  /*
  Accessible as a global variable outside hoist() function
  Output: 20
  */
  
  console.log(b);
  /*
  Since it was declared, it is confined to the hoist() function scope.
  We can't print it out outside the confines of the hoist() function.
  Output: ReferenceError: b is not defined
  NO 200 in my case
  */


console.log('The end of code ')