var zmq = require('zmq');
var req = zmq.socket('req');

if (process.argv.length < 5) {
    console.log('Usage: node lbclient url client-id message');
    process.exit(-1);
}

var url = process.argv[2];
var id  = process.argv[3];
var msg = process.argv[4];

req.identity = id;
req.connect(url);

req.on('message', function(data) {
    console.log(data.toString());
    req.close();
});

req.send(msg);
