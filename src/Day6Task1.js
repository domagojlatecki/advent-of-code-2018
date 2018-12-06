var points = [];
var allIds = [];
var areaSizes = [];
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
    allIds.push(i - 2);
    areaSizes.push(0);
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

var coordinatesToClosestId = {};

for (var i = xCoord.min; i <= xCoord.max; i++) {
    for (var j = yCoord.min; j <= yCoord.max; j++) {
        var key = i + "," + j;
        var value = {};

        for (var k = 0; k < points.length; k++) {
            var p = points[k];
            var dist = distance(p, { x: i, y: j });

            if (k == 0 || value.dist > dist) {
                value.id = p.id;
                value.dist = dist;
            } else if (value.dist == dist) {
                value.id = -1;
                value.dist = dist;
            }
        }

        if (value.id != -1) {
            areaSizes[value.id] += 1;
        }

        coordinatesToClosestId[key] = value;
    }
}

var nonInfiniteIds = [];

for (var i = 0; i < allIds.length; i++) {
    var id = allIds[i];
    var onEdge = false;

    for (var j = xCoord.min; j <= xCoord.max; j++) {
        if (coordinatesToClosestId[j + "," + yCoord.min].id == id) {
            onEdge = true;
        }

        if (coordinatesToClosestId[j + "," + yCoord.max].id == id) {
            onEdge = true;
        }
    }

    for (var j = yCoord.min; j <= yCoord.max; j++) {
        if (coordinatesToClosestId[xCoord.min + "," + j].id == id) {
            onEdge = true;
        }

        if (coordinatesToClosestId[xCoord.max + "," + j].id == id) {
            onEdge = true;
        }
    }

    if (!onEdge) {
        nonInfiniteIds.push(id);
    }
}

var maxSize = 0;

for (var i = 0; i < areaSizes.length; i++) {
    if (areaSizes[i] > maxSize && nonInfiniteIds.indexOf(i) > -1) {
        maxSize = areaSizes[i];
    }
}

console.log(maxSize);
