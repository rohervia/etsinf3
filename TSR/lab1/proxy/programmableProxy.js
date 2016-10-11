var net = require('net');

var LOCAL_PORT = 8000;
var LOCAL_IP = '127.0.0.1';
var CONFIG_PORT = 8001;
var REMOTE_PORT = Number(process.argv[2]);
var REMOTE_IP = process.argv[3];

var server = net.createServer(function(socket) {
    socket.on('data', function(msg) {
        var serviceSocket = new net.Socket();
        serviceSocket.connect(parseInt(REMOTE_PORT), REMOTE_IP, function() {serviceSocket.write(msg);});
        serviceSocket.on('data', function(data){socket.write(data);});
    });
}).listen(LOCAL_PORT, LOCAL_IP);

var programServer = net.createServer(function(socket) {
    socket.on('data', function(msg) {
        var connection = JSON.parse(msg);
        REMOTE_PORT = connection.port;
        REMOTE_IP   = connection.ip;
        console.log("The configuration has changed, new configuration is " + REMOTE_IP + ":" + REMOTE_PORT);
    });
}).listen(CONFIG_PORT, LOCAL_IP);

console.log("Redirecting connections to " + REMOTE_IP + ":" + REMOTE_PORT);
console.log("TCP server accepting connection on port: " + LOCAL_PORT);
console.log("TCP server accepting configs on port: " + CONFIG_PORT);
