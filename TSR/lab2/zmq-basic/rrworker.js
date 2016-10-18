var zmq = require('zmq');
var responder = zmq.socket('rep');

var dealerURL = process.argv[2];
var workTime = parseInt(process.argv[3]) * 1000;
var message  = process.argv.splice(4).join(' ');

responder.connect(dealerURL);
responder.on('message', function(msg) {
    console.log('received request: ', msg.toString());
    setTimeout(function() {responder.send(message);}, workTime);
});
