var zmq = require('zmq');
var requester = zmq.socket('req');

var routerURL = process.argv[2];
var identity  = process.argv[3];
var requests  = parseInt(process.argv[4]);
var message   = process.argv.splice(5).join(' ');

requester.identity = identity;

requester.connect(routerURL);
var replyNbr = 0;
requester.on('message', function(msg) {
    console.log('got reply ', replyNbr++, '\n', msg.toString());
    if (replyNbr == requests) {
        console.log('Process completed!');
        process.exit(0);
    }
});

for (var i = 0; i < requests; i++) {
    requester.send(message);
}
