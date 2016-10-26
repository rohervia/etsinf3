var zmq = require('zmq');
var req = zmq.socket('req');

if (process.argv.length < 6) {
    console.log('Usage: node lbworker url id available-msg response-msg [-v]')
    process.exit(-1);
}

var url = process.argv[2];
var id  = process.argv[3];
var available = process.argv[4];
var resultmsg = process.argv[5];
var verbose   = process.argv.length == 7 && process.argv[6] == '-v';
if (verbose) console.log ('Arguments are correct!');

req.identity = id;
req.connect(url);
if (verbose) console.log('Worker connected to: ' + url);

req.on('message', function() {
    var msg = Array.apply(null, arguments);
    if (verbose) console.log('Received message: ' + msg);
    msg[2] = resultmsg;
    setTimeout(function() {
        req.send(msg);
        if (verbose) console.log('Sent response');
    }, 1000);
});

req.send(available);
if (verbose) console.log('Init message sent');
