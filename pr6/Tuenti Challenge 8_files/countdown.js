var countDown = function(timestamp) {
    var pad2 = function(s) {
        return String(s).length < 2 ? '0' + s : s;
    };
    var refresh = function(days, hours, mins, secs) {
        document.getElementById('cd-days').innerHTML = pad2(days);
        document.getElementById('cd-hours').innerHTML = pad2(hours);
        document.getElementById('cd-mins').innerHTML = pad2(mins);
        document.getElementById('cd-secs').innerHTML = pad2(secs);
    };
    var s = timestamp - Math.floor(Date.now() / 1000);
    if (s <= 0) {
        refresh(0, 0, 0, 0);
        return;
    }
    var m = Math.floor(s / 60);
    s = s % 60;
    var h = Math.floor(m / 60);
    m = m % 60;
    var d = Math.floor(h / 24);
    h = h % 24;
    refresh(d, h, m, s);
    setTimeout(function() {
        countDown(timestamp);
    }, 1000);
};
