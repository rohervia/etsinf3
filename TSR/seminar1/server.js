var net = require('net');
var fun = require('./myFunctions.js');

var end_listener = function() {console.log('Server disconnected');}
var error_listener = function() {console.log('Some connection error');}
var bound_listener = function() {console.log('Server bound');}

var server = net.createServer( (socket) => {
    socket.on('close', end_listener);
    socket.on('error', error_listener);
    socket.on('data', (data) => {
        var json = JSON.parse(data);
        console.log(json.func + "(" + json.numb + ")");
        var result = NaN;
        if (json.func == 'fibo') {
            result = fun.fibo(json.numb);
        } else if (json.func == 'fact') {
            result = fun.fact(json.numb);
        }
        socket.write(json.func + "(" + json.numb + ") = " + result);
    });
});

server.listen(8000, bound_listener);
