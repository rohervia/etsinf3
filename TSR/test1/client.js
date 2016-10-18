var net = require('net');

var msg = {};
var count = 0;
var party;

console.log('Enter a province:');
process.stdin.on('data', (data) => {
    switch (count) {
        case 0: msg.province = data.toString().trim();
            console.log('Enter a pollplace:');
            count++;
            break;
        case 1: msg.pollplace = data.toString().trim();
            console.log('Enter a political party:');
            count++;
            break;
        case 2:
            if (data.toString().trim() == "") {
                console.log('Sending to central government...');
                send(msg, 'localhost', 8000, () => {
                    msg = {};
                    console.log('Enter a province:');
                });
                count = 0;
                break;
            } else {
                party = data.toString().trim();
                console.log('Now enter the number of votes:');
                count++;
            }
            break;
        case 3: msg[party] = parseInt(data.toString().trim());
            console.log('Enter a political party, input nothing to end:');
            count--;
            break;
        default: console.log('[ERROR] Something has gone wrong! count = ' + count); break;
    }
});

function send(msg, ip, port, callback) {
    var socket = net.connect({host:ip, port:port}, () => {
        socket.write(JSON.stringify(msg));
        console.log('Message sent!');
        socket.end();
        callback();
    });
}
