/*
Flow control

*/

// throw -- 

function f_name(name)
{
    if (name == ''){
    throw 'a NAME must be instanced'
    //throw new Error()
    } else
    {console.log(` ===> The name type is ${name}`)}
}

try{
    
    f_name('joao ');
    f_name(''); // until here is executed
    f_name('pedro '); //it was losted

}   catch(e)
{
console.log(e)
}

// try............catch
console.log('The application reach up to here .... normally')



