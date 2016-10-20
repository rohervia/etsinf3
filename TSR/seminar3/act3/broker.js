var zmq = require('zmq');
var frontend = zmq.socket('router');
var backend  = zmq.socket('dealer');

var routerPort = parseInt(process.argv[2]);
var dealerPort = parseInt(process.argv[3]);

frontend.bindSync('tcp://*:' + routerPort);
backend.bindSync('tcp://*:' + dealerPort);

frontend.on('message', function() {
    backend.send(Array.apply(null, arguments));
});

backend.on('message', function() {
    frontend.send(Array.apply(null, arguments));
})
