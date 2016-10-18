var zmq = require('zmq');
var responder = zmq.socket('rep');

responder.connect('tcp://localhost:5560');
responder.on('message', function(msg) {
    console.log('received request: ', msg.toString());
    setTimeout(function() {responder.send('World');}, 1000);
});
