var zmq = require('zmq');
var frontend = zmq.socket('router');
var backend  = zmq.socket('router');

var workers = {};

if (process.argv.length < 4 || process.argv.length > 5) {
    console.log('Usage: node lbbroker port1 port2 [-v]');
    process.exit(-1);
}

var frontport = process.argv[2];
var backport  = process.argv[3];
var verbose   = process.argv.length == 5 && process.argv[4] == '-v';

frontend.bindSync('tcp://*:' + frontport);
backend.bindSync('tcp://*:' + backport);
if (verbose) {
    console.log('Frontend on: tcp://localhost:' + frontport);
    console.log('Backend on: tcp://localhost:' + backport);
}

frontend.on('message', function() {
    var args = Array.apply(null, arguments);
    if (verbose) console.log('Received: ' + args.toString());
    args.unshift('');
    var sent = false;
    while (!sent) {
        var minServed = Number.MAX_VALUE;
        var minId = undefined;
        for (w in workers) {
            if (workers[w].ready && workers[w].served < minServed) {
                minServed = workers[w].served;
                minId = w;
            }
        }
        if (minId != undefined) {
            args.unshift(minId);
            backend.send(args);
            workers[minId].ready = false;
            workers[minId].served++;
            sent = true;
            if (verbose) console.log('Sent to ', minId, ' message: ', args);
        }
    }
});

backend.on('message', function() {
    var args = Array.apply(null, arguments);
    if (args.length == 3) {
        // Activation message
        if (workers[args[0]] == undefined) {
            workers[args[0]] = {'ready':true, 'served':0};
            if (verbose) console.log('Worker registered with id: ' + args[0]);
        } else {
            if (verbose) console.log('This worker was already registered as (' + args[0] + ' - ' + workers[args[0]] + ')');
        }
    } else {
        if (verbose) console.log('Response from worker ' + args[0]);
        workers[args[0]].ready = true;
        args.splice(0,2);
        frontend.send(args);
    }
})
