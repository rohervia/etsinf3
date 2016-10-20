var zmq = require('zmq');
var math = require('./myMath.js');
var server = zmq.socket('req');

var backendPort = process.argv[2];

console.log('Connecting to port ', backendPort);
server.connect('tcp://localhost:' + backendPort);
server.on('message', function(msg) {
    var obj = JSON.parse(msg);
    var res = math.eval(obj.func, obj.numb);
    var resp = obj.func + '(' + obj.numb + ') = ' + res;
    setTimeout(() => {server.send(resp);}, 1000);
});
