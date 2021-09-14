// Criando e  subindo  um servidor http

//const VAR_express = require('express');
const VAR_http = require('http');
//const VAR_app = express();

// a ideia é eh ler um HTML do node, para isto

//const var_fs =  require ('fs'); // operações de arquivos
//const var_path =  require ('path'); // nomes e diretorios 


VAR_http.createServer ((req, res)  => {
    
    if(req.url == '/')
        return res.end('<h1> Home ... Page </h1>');

    
    if(req.url == '/contacto')
        return res.end('<h2> Página Contacto </h2>');        
        //http://localhost:5000/contacto

    console.log(req);
    return;
    
    //res.write
    //res.end()


}).listen(5000, () => console.log('This server is running: 5000'))
//, address().port  
