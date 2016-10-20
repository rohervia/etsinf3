var zmq = require('zmq');
var frontend = zmq.socket('router');
var backend  = zmq.socket('router');

var routerPort = parseInt(process.argv[2]);
var dealerPort = parseInt(process.argv[3]);

function rotate(q) {
    var aux = q[0];
    for (var i = 1; i < q.length; i++)
        q[i - 1] = q;
    return q;
}


frontend.bindSync('tcp://*:' + routerPort);
backend.bindSync('tcp://*:' + dealerPort);

frontend.on('message', function() {
    backend.send(Array.apply(null, arguments));
});

backend.on('message', function() {
    frontend.send(Array.apply(null, arguments));
})
