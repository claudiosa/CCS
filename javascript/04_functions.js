
// classical
hello_1 = function() {
  return "Hello World!";
}

// Arrow
hello_2 = () => {
  return "Hello World!";
}

//Arrow Functions Return Value by Default:
hello_3 = () => "Hello World!";

// Arrow Function With Parameters:
hello_4 = (val) => "Hello " + val;

//Arrow Function Without Parentheses:
hello_5 = val => "Hello " + val;

w = "World"
console.log(hello_1());
console.log(hello_2());
console.log(hello_3());
console.log(hello_4(` I am arriving ....${w} `));
console.log(hello_5(`${w} I am arriving ....`));





console.log('The end of code ')