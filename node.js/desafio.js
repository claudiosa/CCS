//console.log(process.argv)
// [ '/usr/bin/node', '/home/ccs/my_main/CCS/node.js/01_process.js' ]
/*
[ccs@vosges node.js]$ node 01_process.js xxxx yyy xxxx
[
  '/usr/bin/node',
  '/home/ccs/my_main/CCS/node.js/01_process.js',
  'xxxx',
  'yyy',
  'xxxx'
]

console.log(process.argv[0]+ ' CONCATENANDO ' + process.argv[1])
[ccs@vosges node.js]$ node 01_process.js xxxx yyy xxxx
/usr/bin/node CONCATENANDO /home/ccs/my_main/CCS/node.js/01_process.js
*/
//console.log(process.argv) // pega TUDO

// --name --greeting

//all_from_prompt function() = return (process.arg)
//hello_hello_3 = () => "Hello World!";
////= () => process.argv;
all_from_prompt 
    = function() {
      return process.argv.indexof;
  }
//console.log(hello_hello_3)
//console.log(all_from_prompt)


