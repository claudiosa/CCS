const http = require('http');

http.createServer((requisicao, resposta)  => 
{
    resposta.writeHead(200, {'Content-type':'text/plain'});
    resposta.write(' Estamos no curso \n ');
    resposta.write(' agora vai... \n ');
    resposta.end();

}).listen(1337);
console.log('Está rodando ....');
console.log('^ to halt ....and node file.js to start againa');