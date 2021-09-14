

//>node mostra_MEM.js
// importando um módulo
const VAR_os = require('os');

//importando um user-module
const f_log = require('./eventos'); //./ : pasta local ou corrent




// uma função global

setInterval( () => {
    
    const { freemem, totalmem } = VAR_os

    const  total = parseInt ( totalmem() / 1024/1024 );
    const  mem = parseInt( freemem() / 1024/1024 );
    const  porcent = parseInt( ( mem / total ) * 100 );

    const status = {
        free : `${mem} MegaBytes` , //formatando
        total : `${total} MegaBytes` , //formatando
        usage : `${porcent} %`  //formatando
    }
    
    console.clear();
    //console.log("=========== STATUS ================");
    f_log("=========== STATUS ================");
    // prints time in HH:MM format
    //console.log(hours + ":" + minutes + ":" + seconds);
    f_log(get_my_time());
    console.table(status);

    //já formatando numa saída json
    f_log(` ${JSON.stringify(status)} \n `) ; // 1 linha por passada.



    }, 1000)


function get_my_time() {
    let date_object = new Date();
    // current hours
    let hours = date_object.getHours();
    // current minutes
    let minutes = date_object.getMinutes();
    // current seconds
    let seconds = date_object.getSeconds();
    return(hours + "h:" + minutes + "m:" + seconds+"s");
}