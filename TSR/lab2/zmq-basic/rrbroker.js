var zmq = require('zmq');
var frontend = zmq.socket('router');
var backend  = zmq.socket('dealer');

var routerPort = parseInt(process.argv[2]);
var brokerPort = parseInt(process.argv[3]);

frontend.bindSync('tcp://*:' + routerPort);
backend.bindSync('tcp://*:' + brokerPort);

frontend.on('message', function() {
    var args = Array.apply(null, arguments);
    backend.send(args);
});

backend.on('message', function() {
    var args = Array.apply(null, arguments);
    frontend.send(args);
});
