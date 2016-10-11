var net = require('net');

var msg = JSON.stringify({
    "ip":process.argv[4],
    "port":process.argv[5]
});

var socket = net.connect({port:process.argv[3], address:process.argv[2]},
    function() {socket.write(msg); socket.end();});
