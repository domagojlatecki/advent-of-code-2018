declare var process: {
    argv: Array<string>
    exit(): void
};

let lines = process.argv.slice(2);
let numSteps = 20;
var extension = "";

for (var i = 0; i < numSteps * 3; i++) {
    extension += ".";
}

var currentState = extension + lines[0].substring("initial state: ".length) + extension;

let transitions: {
    [key: string]: string
} = {};

for (let transition of lines.slice(2)) {
    let split = transition.split(" => ");
    transitions[split[0]] = split[1];
}

for (var i = 0; i < numSteps; i++) {
    var nextState = "..";

    for (var j = 2; j < currentState.length - 2; j++) {
        let potSurroundings = currentState.substring(j - 2, j + 3);
        let newPotState = transitions[potSurroundings];

        nextState += newPotState;
    }

    currentState = nextState + "..";
}

var aliveIndicesSum = 0;

for (var i = 0; i < currentState.length; i++) {
    if (currentState[i] == "#") {
        aliveIndicesSum += i - extension.length;
    }
}

console.log(aliveIndicesSum);
