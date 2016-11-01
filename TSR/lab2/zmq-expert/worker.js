var zmq = require('zmq');
var aux = require('./auxfunctions.js');
var req = zmq.socket('req');
var status = zmq.socket('rep');

if (process.argv.length < 7 || process.argv.length > 8) {
    console.log('Usage: node worker broker-url statusport id message availablemessage [-v]');
    process.exit(-1);
}

var url = process.argv[2];
var statusport = process.argv[3];
var identity = process.argv[4]
var message = process.argv[5];
var available = process.argv[6]
var debug = function() {};
if (process.argv.length == 8 && process.argv[7] == '-v')
    debug = console.log;
debug('Arguments are correct!');

status.identity = identity;
status.bindSync('tcp://*:' + statusport);
debug('Status port ready at ' + statusport);

req.identity = identity;
req.connect(url);
debug('Connected to broker at ' + url);

status.on('message', function() {
    status.send(aux.getLoad());
});

req.on('message', function() {
    var msg = Array.apply(null, arguments);
    debug('Received message from ' + msg[0]);
    for (var k in msg)
        debug('\tPart', k, ':', msg[k].toString());
    msg[2] = message;
    setTimeout(function() {
        req.send(msg);
        debug('Sent response:');
        for (var k in msg)
            debug('\tPart', k, ':', msg[k].toString());
    }, 1000);
});

req.send(available);
debug('Init message sent');
