declare var process: {
    argv: Array<string>
    exit(): void
};

let lines = process.argv.slice(2);
let numSteps = 50_000_000_000;
var extension = "..";
var offset = extension.length;
var currentState = extension + lines[0].substring("initial state: ".length) + extension;

let transitions: {
    [key: string]: string
} = {};

for (let transition of lines.slice(2)) {
    let split = transition.split(" => ");
    transitions[split[0]] = split[1];
}

var prevSum = 0;
var prevDiff = 0;
var numSameSums = 0;
var lastI = 0;

for (var i = 0; i < numSteps; i++) {
    var nextState = "..";

    for (var j = 2; j < currentState.length - 2; j++) {
        let potSurroundings = currentState.substring(j - 2, j + 3);
        let newPotState = transitions[potSurroundings];

        nextState += newPotState;

        if (j == currentState.length - 3 && newPotState == "#") {
            nextState = nextState + ".";
        }
    }

    currentState = nextState + "..";

    var aliveIndicesSum = 0;

    for (var k = 0; k < currentState.length; k++) {
        if (currentState[k] == "#") {
            aliveIndicesSum += k - offset;
        }
    }

    if (prevDiff == aliveIndicesSum - prevSum) {
        numSameSums += 1;
    } else {
        numSameSums = 0;
    }

    prevDiff = aliveIndicesSum - prevSum;
    prevSum = aliveIndicesSum;

    if (numSameSums == 5) {
        lastI = i + 1;
        break;
    }
}

console.log(prevSum + (50_000_000_000 - lastI) * prevDiff);
