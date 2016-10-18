var fs = require('fs');
var total_votes = {};
var votes = {};
var count = -1;

fs.readdir('.', function(err, files) {
    count = files.length;
    var regex = new RegExp('.txt');
    files.forEach(function (file) {
        if (regex.test(file))
            fs.readFile(file, function(err, data) {
                var d = JSON.parse(data);
                votes[file.substring(0, file.length - 4)] = d;
                for (var v in d)
                    if (total_votes[v] == undefined) total_votes[v] = d[v];
                    else total_votes[v] += d[v];
                count--;
            });
        else count--;
    });
});

setTimeout(function () {if (count != 0) return; count = -1; printResults();}, 1000);

function printResults() {
    console.log('Resultados globales:');
    console.log(JSON.stringify(total_votes));
    console.log('\nProvincia:');
    process.stdin.on('data', function (data) {
        var data = data.toString().trim();
        if (votes[String(data)] == undefined)
            console.log('No hay datos electorales para ' + data);
        else
            console.log('votos en ' + data + ':' + JSON.stringify(votes[data]));
        console.log('\nProvincia:');
    });
}
