var zmq = require('zmq');
var frontend = zmq.socket('router');
var backend  = zmq.socket('router');

var workers = {};

if (process.argv.length < 4 || process.argv.length > 5) {
    console.log('Usage: node broker port1 port2 [-v]');
    process.exit(-1);
}

var frontport = process.argv[2];
var backport  = process.argv[3];
var debug = function() {};
if (process.argv.length == 5 && process.argv[4] == '-v') {
    debug = console.log;
}
debug('Arguments are correct!');

frontend.bindSync('tcp://*:' + frontport);
backend.bindSync('tcp://*:' + backport);

debug('Frontend ready at port ' + frontport);
debug('Backend  ready at port ' + backport);

frontend.on('message', function() {
    var msg = Array.apply(null, arguments);
    debug('Received message');
    for (k in msg)
        debug('\tPart ', k, ': ', msg[k]);
    msg.unshift('');
    var sent = false;
    while (!sent) {
        var minLoad = Number.MAX_VALUE;
        var minId   = undefined;
        for (w in workers) {
            if (workers[w].ready && workers[w].load < minLoad) {
                minLoad = workers[w].load;
                minId   = w;
            }
        }
        if (minId != undefined) {
            msg.unshift(minId);
            backend.send(args);
            workers[minId].ready = false;
            sent = true;
            debug('Sent message to ', minId);
            for (k in msg)
                debug('\tPart ', k, ': ', msg[k]);
        }
    }
});

backend.on('message', function() {
    var msg = Array.apply(null, arguments);
    if (msg.length == 4) {
        if (workers[msg[0]] == undefined) {
            workers[msg[0]] = {
                'ready':true,
                'load':parseInt(msg[2]),
                'port':parseInt(msg[3])
            };
            debug('Worker ', msg[0], ' registered. Config port is ', msg[3]);
        } else {
            debug('The worker id ', msg[0], ' has been already registered.');
        }
    } else {
        debug('Response from worker ', msg[0]);
        for (k in msg)
            debug('\tPart ', k, ': ', msg[k]);
        workers[msg[0]].ready = true;
        msg.splice(0,2);
        frontend.send(msg);
    }
});

setTimeout(function() {
    for (w in workers) {
        checkStatus(w);
    }
}, 5000);

function checkStatus(id) {
    var req = zmq.socket('req');
    req.connect('tcp://localhost:' + workers[id].port);
    req.on('message', function(msg) {
        workers[id].load = parseInt(msg);
        req.close();
    });
    req.on('')
    req.send('ping');
}
