var zmq = require('zmq');
var requester = zmq.socket('req');

requester.identity = 'CLIENT1';

requester.connect('tcp://localhost:5555');
var replyNbr = 0;
requester.on('message', function(msg) {
    console.log('got reply ', replyNbr++, '\n', msg.toString());
});

for (var i = 0; i < 10; i++) {
    requester.send('Hello');
}
