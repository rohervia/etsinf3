var net = require('net');

var PROXY_PORT = 8000;

var msg = JSON.stringify({
    'op':"set",
    "inPort":parseInt(process.argv[3]),
    'remote':{
        "ip":process.argv[4],
        "port":process.argv[5]
    }
});

var socket = net.connect({port:PROXY_PORT, address:process.argv[2]},
    function() {socket.write(msg); socket.end();});
