/*
Flow control

*/

// program for a simple calculator



function f_calculator(number1, operator, number2)
{

let result;
// take the operator input
//const operator = prompt('Enter operator ( either +, -, * or / ): ');
// take the operand input
//const number1 = parseFloat(prompt('Enter first number: '));
//const number2 = parseFloat(prompt('Enter second number: '));

switch(operator) {
    case '+':
         result = number1 + number2;
        console.log(`${number1} + ${number2} = ${result}`);
        break;

    case '-':
         result = number1 - number2;
        console.log(`${number1} - ${number2} = ${result}`);
        break;

    case '*':
         result = number1 * number2;
        console.log(`${number1} * ${number2} = ${result}`);
        break;

    case '/':
         result = number1 / number2;
        console.log(`${number1} / ${number2} = ${result}`);
        break;

    default:
        console.log('Invalid operator');
        break;
}
}


f_calculator(3, '*', 4)

console.log('The end of code ')



