var zmq = require('zmq');

if (process.argv.length < 5) {
    console.log('Usage:\n\tnode hwclient.js serverAddress amountRequests message');
    process.exit(-1);
}

var serverURL = process.argv[2];
var count     = parseInt(process.argv[3]);
var message   = process.argv.splice(4).join(' ');


console.log('Connecting to server...');
var requester = zmq.socket('req');

var x = 0;
requester.on('message', function(reply) {
    console.log('Received reply ', x, ': [', reply.toString(), ']');
    x++;
    if (x == count) {
        requester.close();
        process.exit(0);
    }
});

requester.connect(serverURL);

for (var i = 0; i < count; i++) {
    console.log('Sending request', i, '...');
    requester.send(message);
}

process.on('SIGINT', () => {requester.close();});
