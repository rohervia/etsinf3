var zmq = require('zmq');
var frontend = zmq.socket('router');
var backend  = zmq.socket('dealer');

frontend.bindSync('tcp://*:5559');
backend.bindSync('tcp://*:5560');

frontend.on('message', function() {
    var args = Array.apply(null, arguments);
    backend.send(args);
});

backend.on('message', function() {
    var args = Array.apply(null, arguments);
    frontend.send(args);
});
