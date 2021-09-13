
const EventEmitter = require('events');

const emissor = new EventEmitter;

emissor.on('f_log', (PARAM_f_log) => {
    console.log(PARAM_f_log);
})

function f_log(PARAM_f_log ) {
    emissor.emit('f_log' , PARAM_f_log);
}

// with error YET
// function f_log_arrow(  (PARAM_f_log)  => {
//    emissor.emit('f_log_arrow' , PARAM_f_log);
// })


f_log(" algo");
f_log(" aqui");
f_log("e lá");
