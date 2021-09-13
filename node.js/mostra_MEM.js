

//>node mostra_MEM.js
// importando um módulo
const VAR_os = require('os');

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
    console.log("=========== STATUS ================");
    console.table(status);
    }, 1000)

