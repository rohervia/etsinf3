var zmq = require('zmq');

if (process.argv.length < 5) {
    console.log('Usage:\n\tnode hwserver.js port seconds message');
    process.exit(-1);
}

var port = process.argv[2];
var time = parseInt(process.argv[3]) * 1000;
var msg  = process.argv.splice(4).join(' ');

var responder = zmq.socket('rep');

responder.on('message', function(request) {
    console.log('Received request: [', request.toString(), ']');
    setTimeout(() => {responder.send(request + " " + msg);}, time);
});

responder.bind('tcp://*:' + port, function (err) {
    if (err) console.log(err);
    else console.log('Listening on ', port, '...');
});

process.on('SIGINT', () => {responder.close();});
