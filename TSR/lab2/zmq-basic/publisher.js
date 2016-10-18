var zmq = require('zmq');
var aux = require('../sources/auxfunctions.js');
var publisher = zmq.socket('pub');

var port  = parseInt(process.argv[2]);
var count = parseInt(process.argv[3]);
var types = process.argv.splice(4);

publisher.bind('tcp://*:' + port, function(err) {
    if (err) console.log(err);
    else console.log('Listing on ', port, '...');
});

for (var i = 1; i <= count; i++) {
    setTimeout(function() {
        for (var j = 0; j < types.length; j++) {
            console.log('sent ', types[j]);
            publisher.send(types[j] + aux.randNumber(1000));
        }
    }, 1000 * i);
}

process.on('SIGINT', function() {
    publisher.close();
    console.log('\nClosed');
});
