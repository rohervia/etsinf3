function fibo(n) {
    return (n < 2) ? 1 : fibo(n - 2) + fibo(n - 1);
}

function fact(n) {
    return (n < 2) ? 1 : n * fact(n - 1);
}

function prime(n) {
    if (n != 2 && n % 2 == 0) return false;
    for (var i = 3; i <= Math.sqrt(n); i += 2)
        if (n % i == 0) return false;
    return true;
}

function calculate(f, n) {
    var res = 0;
    switch (f) {
        case 'fibo': res = fibo(n); break;
        case 'fact': res = fact(n); break;
        case 'prim': res = prime(n); break;
        case 'sin' : res = Math.sin(n); break;
        case 'cos' : res = Math.cos(n); break;
        case 'tan' : res = Math.tan(n); break;
        case 'log' : res = Math.log(n); break;
        case 'exp' : res = Math.exp(n); break;
        case 'sqrt': res = Math.sqrt(n); break;
        default:     res = NaN;
    }
    return res;
}

ids = ['fibo', 'fact', 'prim', 'sin', 'cos', 'tan', 'log', 'exp', 'sqrt', 'strange'];

exports.eval = calculate;
exports.funcs = ids;
