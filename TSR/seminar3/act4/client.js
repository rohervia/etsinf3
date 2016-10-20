var zmq = require('zmq');
var requester = zmq.socket('req');

var port = process.argv[2];
var op = {'func':process.argv[3],'numb':parseInt(process.argv[4]),'heavy':false};

requester.connect('tcp://localhost:' + port);
requester.on('message', function(msg) {
    console.log(msg.toString());
    requester.close();
});

if (op.func == 'fibo' || op.func == 'fact' || op.func == 'prim') op.heavy = true;
requester.send(JSON.stringify(op));
