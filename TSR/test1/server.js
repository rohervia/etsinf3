var net = require('net');
var fs  = require('fs');
var votes = {};

var server = net.createServer(function (c) {
    c.on('data', function(data) {
        var d = JSON.parse(data);
        console.log('Received: ' + data);
        var p = d.province;
        delete d.province; delete d.pollplace;
        if (votes[p] == undefined) votes[p] = d;
        else
            for (var i in d)
                if (votes[p][i] == undefined) votes[p][i] = d[i];
                else votes[p][i] += d[i];

    });
});

server.listen(8000, () => {console.log('Server bound');});

function save() {
    for (var v in votes) fs.writeFileSync(v + '.txt', JSON.stringify(votes[v]));
    console.log('Data saved!');
}

setInterval(() => {save();}, 20000);
