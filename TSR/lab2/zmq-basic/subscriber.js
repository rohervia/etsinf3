var zmq = require('zmq');
var subscriber = zmq.socket('sub');

var url = process.argv[2];
var filter = process.argv[3];

subscriber.on('message', function(reply) {
    console.log('Received message: ', reply.toString());
});

subscriber.connect(url, function () {console.log('Connected');});
subscriber.subscribe(filter);

process.on('SIGINT', function() {
    subscriber.close();
    console.log('\nClosed');
});
