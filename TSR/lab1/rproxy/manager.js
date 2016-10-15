var net = require('net');

var PROXY_PORT = 8000;
var msg;


if (process.argv[2] == 'set' && process.argv.length == 6) {
    msg = JSON.stringify({
        'op':process.argv[2],
        "inPort":parseInt(process.argv[3]),
        'remote':{
            "ip":process.argv[4],
            "port":process.argv[5]
        }
    });
} else if (process.argv[2] == 'rm' && process.argv.length == 4) {
    msg = JSON.stringify({
        'op':process.argv[2],
        'inPort':parseInt(process.argv[3])
    });
}

var socket = net.connect({port:PROXY_PORT, address:'localhost'},
    function() {socket.write(msg); socket.end();});
