var points = [];
var xCoord = { min: null, max: null };
var yCoord = { min: null, max: null };

function setCoord(coord, value) {
    if (coord.min == null || coord.min > value) {
        coord.min = value;
    }

    if (coord.max == null || coord.max < value) {
        coord.max = value;
    }
}

for (var i = 2; i < process.argv.length; i++) {
    var split = process.argv[i].split(",");
    var x = +split[0];
    var y = +split[1];

    setCoord(xCoord, x);
    setCoord(yCoord, y);

    points.push({ x: x, y: y, id: i - 2 });
}

function distance(p1, p2) {
    return Math.abs(p1.x - p2.x) + Math.abs(p1.y - p2.y);
}

var maxDistanceBetweenPoints = 0;

for (var i = 0; i < points.length; i++) {
    for (var j = 0; j < points.length; j++) {
        var dist = distance(points[i], points[j]);

        if (dist >= maxDistanceBetweenPoints) {
            maxDistanceBetweenPoints = dist;
        }
    }
}

xCoord.min -= maxDistanceBetweenPoints;
xCoord.max += maxDistanceBetweenPoints;
yCoord.min -= maxDistanceBetweenPoints;
yCoord.max += maxDistanceBetweenPoints;

var count = 0;

for (var i = xCoord.min; i <= xCoord.max; i++) {
    for (var j = yCoord.min; j <= yCoord.max; j++) {
        var value = 0;

        for (var k = 0; k < points.length; k++) {
            value += distance(points[k], { x: i, y: j });
        }

        if (value < 10000) {
            count += 1;
        }
    }
}

console.log(count);
