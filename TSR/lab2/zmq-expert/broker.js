var zmq = require('zmq');
var frontend = zmq.socket('router');
var backend  = zmq.socket('router');
var workers = {}, ready = 0;
var workqueue = [];

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
        debug('\tPart ', k, ': ', msg[k].toString());
    msg.unshift('');
    workqueue.push(msg);
});

backend.on('message', function() {
    var msg = Array.apply(null, arguments);
    if (msg.length == 4) {
        // Register message
        if (workers[msg[0]] == undefined || !workers[msg[0]].ready) ready++;
        workers[msg[0]] = {'ready':true,'load':parseInt(msg[2]),'port':parseInt(msg[3])};
        debug('Worker ', msg[0].toString(), ' registered.');
    } else {
        // Response message
        debug('Response from worker ', msg[0].toString());
        for (k in msg)
            debug('\tPart ', k, ': ', msg[k].toString());
        workers[msg[0]].ready = true;
        ready++;
        msg.splice(0,2);
        frontend.send(msg);
    }
});

setInterval(function() {
    debug('Status check');
    for (w in workers) {
        checkStatus(w);
    }
}, 20000);

setInterval(function() {
    debug('Checking msg queue, ready = ', ready, ', workqueue.length = ', workqueue.length);
    while (workqueue.length > 0 && ready > 0) {
        for (e in workqueue) {
            sendWork(workqueue[e]);
            workqueue.splice(e, 1);
            ready--;
        }
    }
}, 500);

function sendWork(msg) {
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
        backend.send(msg);
        workers[minId].ready = false;
        debug('Sent message to ' + minId);
        for (k in msg)
            debug('Part ' + k + ': ' + msg[k].toString());
    } else {
        workqueue.push(msg);
        ready++;
    }
}

function checkStatus(id) {
    var req = zmq.socket('req');
    req.connect('tcp://localhost:' + workers[id].port, function (err) {
        if (err) {
            debug('Worker ' + id + ' unavailable.');
            workers[id].load = Number.NaN;
            ready--;
        }
    });
    req.on('message', function(msg) {
        debug('Worker ' + id + ' available with load ' + msg.toString() + '.');
        workers[id].load = parseInt(msg);
        req.close();
    });
    req.send('ping');
}
