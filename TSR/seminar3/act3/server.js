var zmq = require('zmq');
var math = require('./myMath.js');
var responder = zmq.socket('rep');

var backendPort = process.argv[2];

console.log('Connecting to port ', backendPort);
responder.connect('tcp://localhost:' + backendPort);
responder.on('message', function(msg) {
    var obj = JSON.parse(msg);
    var res = math.eval(obj.func, obj.numb);
    var resp = obj.func + '(' + obj.numb + ') = ' + res;
    setTimeout(() => {responder.send(resp);}, 1000);
});
