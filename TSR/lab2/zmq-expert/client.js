var zmq = require('zmq');
var req = zmq.socket('req');

if (process.argv.length != 5) {
    console.log('Usage: node client broker-url id message');
    process.exit(-1);
}

var url = process.argv[2];
var id  = process.argv[3];
var msg = process.argv[4];

req.identity = id;
req.connect(url, function (err) {
    if (err) process.exit(-2);
});

req.on('message', function() {
    var data = Array.apply(null, arguments);
    console.log(data.toString());
    req.close();
});

req.send(msg);

process.on('SIGTERM', function() {
    console.log('Force closing the program...');
    req.close();
    process.exit(-1);
});

