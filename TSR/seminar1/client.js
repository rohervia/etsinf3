var net = require('net');


// The server is in out same machine
var client = net.connect( {port:8000}, function () {
    client.write(JSON.stringify({func:process.argv[2],numb:Number(process.argv[3])}));
});

client.on('data', (data) => {
    console.log(data.toString());
    client.end();
});
