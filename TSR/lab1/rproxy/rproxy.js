var net = require('net');
var fs  = require('fs');

var map = [];
var servers = [];
var CONFIG_PORT = 8000;
var LOCAL_IP = '127.0.0.1';

fs.readFile('rproxy.json', 'utf8', (err, data) => {
    if (err) console.log("[ERROR] " + err);
    else {
        var newMap = JSON.parse(data);
        newMap.forEach((element, index, array) => {
            var server = route(element.inPort, element.ip, element.port)
            map.push({'inPort':element.inPort,'ip':element.ip,'port':element.port});
            servers.push(server);
            logConnection(map.length - 1);
        });
    }
});


var configServer = net.createServer(function(socket) {
    socket.on('data', function(msg) {
        var jmsg = JSON.parse(msg);
        if (jmsg.inPort == CONFIG_PORT) {
            console.log("[WARNING] The config port (" + CONFIG_PORT + ")cannot be rerouted.");
            return;
        }
        if (jmsg.op == 'set') {
            var i;
            for (i = 0; i < map.length; i++) {
                if (map[i].inPort == jmsg.inPort) {
                    servers[i].close();
                    console.log("[WARNING] " + map[i].inPort + " not " + map[i].ip + ":" + map[i].port);
                    map.splice(i, 1);
                    servers.splice(i, 1);
                    break;
                }
            }
            var server = route(jmsg.inPort, jmsg.remote.ip, jmsg.remote.port);
            map.push({'inPort':jmsg.inPort,'ip':jmsg.remote.ip,'port':jmsg.remote.port});
            servers.push(server);
            logConnection(map.length - 1);
            saveConfig();
        } else if (jmsg.op == 'rm') {
            var i;
            for (i = 0; i < map.length; i++) {
                if (map[i].inPort == jmsg.inPort) {
                    servers[i].close();
                    console.log("[INFO] " + map[i].inPort + " not " + map[i].ip + ":" + map[i].port);
                    map.splice(i, 1);
                    servers.splice(i, 1);
                    saveConfig();
                    break;
                }
            }
        }
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

function saveConfig() {
    fs.writeFile('rproxy.json', JSON.stringify(map), (err) => {if (err) console.log("[ERROR] " + err);});
}

function logConnection(i) {
    console.log("[INFO] " + map[i].inPort + " --> " + map[i].ip + ":" + map[i].port);
}

console.log("TCP server accepting configurations on port: " + CONFIG_PORT);
