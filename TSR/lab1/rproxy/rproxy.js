var net = require('net');

var map = [];
var CONFIG_PORT = 8000;
var LOCAL_IP = '127.0.0.1';

var configServer = net.createServer(function(socket) {
    socket.on('data', function(msg) {
        var jmsg = JSON.parse(msg);
        if (jmsg.inPort == CONFIG_PORT) {
            console.log("[WARNING] The config port (" + CONFIG_PORT + ")cannot be rerouted.");
            return;
        }
        var i;
        for (i = 0; i < map.length; i++) {
            if (map[i].inPort == jmsg.inPort) {
                map[i].server.close();
                console.log("[WARNING] " + map[i].inPort + " not " + map[i].ip + ":" + map[i].port);
                map.splice(i, 1);
                break;
            }
        }
        var server = route(jmsg.inPort, jmsg.remote.ip, jmsg.remote.port);
        map.push({'inPort':jmsg.inPort,'ip':jmsg.remote.ip,'port':jmsg.remote.port,'server':server});
        i = map.length - 1;
        console.log("[INFO] " + map[i].inPort + " --> " + map[i].ip + ":" + map[i].port);
    });
}).listen(CONFIG_PORT, LOCAL_IP);

function route(inPort, ip, port) {
    var server = net.createServer(function(socket) {
        socket.on('data', function(msg) {
            var serviceSocket = new net.Socket();
            serviceSocket.connect(parseInt(port), ip, function() {serviceSocket.write(msg);});
            serviceSocket.on('data', function(data) {socket.write(data);});
        });
    }).listen(inPort, LOCAL_IP);
    return server;
}

console.log("TCP server accepting configurations on port: " + CONFIG_PORT);
