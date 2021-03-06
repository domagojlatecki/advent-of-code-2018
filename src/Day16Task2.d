import std.array;
import std.conv;
import std.stdio;
import std.file;

enum State { BEFORE, ARGS, AFTER, EXEC }

int[4] addr(int[4] registers, int a, int b, int c) {
    registers[c] = registers[a] + registers[b];
    return registers;
}

int[4] addi(int[4] registers, int a, int b, int c) {
    registers[c] = registers[a] + b;
    return registers;
}

int[4] mulr(int[4] registers, int a, int b, int c) {
    registers[c] = registers[a] * registers[b];
    return registers;
}

int[4] muli(int[4] registers, int a, int b, int c) {
    registers[c] = registers[a] * b;
    return registers;
}

int[4] banr(int[4] registers, int a, int b, int c) {
    registers[c] = registers[a] & registers[b];
    return registers;
}

int[4] bani(int[4] registers, int a, int b, int c) {
    registers[c] = registers[a] & b;
    return registers;
}

int[4] borr(int[4] registers, int a, int b, int c) {
    registers[c] = registers[a] | registers[b];
    return registers;
}

int[4] bori(int[4] registers, int a, int b, int c) {
    registers[c] = registers[a] | b;
    return registers;
}

int[4] setr(int[4] registers, int a, int b, int c) {
    registers[c] = registers[a];
    return registers;
}

int[4] seti(int[4] registers, int a, int b, int c) {
    registers[c] = a;
    return registers;
}

int[4] gtir(int[4] registers, int a, int b, int c) {
    if (a > registers[b]) {
        registers[c] = 1;
    } else {
        registers[c] = 0;
    }

    return registers;
}

int[4] gtri(int[4] registers, int a, int b, int c) {
    if (registers[a] > b) {
        registers[c] = 1;
    } else {
        registers[c] = 0;
    }

    return registers;
}

int[4] gtrr(int[4] registers, int a, int b, int c) {
    if (registers[a] > registers[b]) {
        registers[c] = 1;
    } else {
        registers[c] = 0;
    }

    return registers;
}

int[4] eqir(int[4] registers, int a, int b, int c) {
    if (a == registers[b]) {
        registers[c] = 1;
    } else {
        registers[c] = 0;
    }

    return registers;
}

int[4] eqri(int[4] registers, int a, int b, int c) {
    if (registers[a] == b) {
        registers[c] = 1;
    } else {
        registers[c] = 0;
    }

    return registers;
}

int[4] eqrr(int[4] registers, int a, int b, int c) {
    if (registers[a] == registers[b]) {
        registers[c] = 1;
    } else {
        registers[c] = 0;
    }

    return registers;
}

int[4] executeCommand(int[4] registers, int opCode, int a, int b, int c) {
    switch (opCode) {
        case 0:
            return addr(registers, a, b, c);
        case 1:
            return addi(registers, a, b, c);
        case 2:
            return mulr(registers, a, b, c);
        case 3:
            return muli(registers, a, b, c);
        case 4:
            return banr(registers, a, b, c);
        case 5:
            return bani(registers, a, b, c);
        case 6:
            return borr(registers, a, b, c);
        case 7:
            return bori(registers, a, b, c);
        case 8:
            return setr(registers, a, b, c);
        case 9:
            return seti(registers, a, b, c);
        case 10:
            return gtir(registers, a, b, c);
        case 11:
            return gtri(registers, a, b, c);
        case 12:
            return gtrr(registers, a, b, c);
        case 13:
            return eqir(registers, a, b, c);
        case 14:
            return eqri(registers, a, b, c);
        case 15:
            return eqrr(registers, a, b, c);
        default:
            assert(0);
            break;
    }
}

bool notInArray(int value, int[] array) {
    for (int i = 0; i < array.length; i++) {
        if (value == array[i]) {
            return false;
        }
    }

    return true;
}

int[16] findOpcodes(bool[16][16] possibleOpcodes) {
    int[][] digits;
    int[] valuesToRemove;

    for (int i = 0; i < 16; i++) {
        int[] d;

        for (int j = 0; j < 16; j++) {
            if (possibleOpcodes[i][j]) {
                d ~= j;
            }
        }

        digits.length += 1;
        digits[i] = d;

        if (d.length == 1) {
            valuesToRemove ~= d[0];
        }
    }

    bool changed = true;

    while (changed) {
        int[] newValuesToRemove;
        changed = false;

        for (int i = 0; i < 16; i++) {
            if (digits[i].length > 1) {
                int[] newDigits;

                for (int j = 0; j < digits[i].length; j++) {
                    if (notInArray(digits[i][j], valuesToRemove)) {
                        newDigits ~= digits[i][j];
                    } else {
                        changed = true;
                    }
                }

                digits[i] = newDigits;
            }

            if (digits[i].length == 1) {
                newValuesToRemove ~= digits[i][0];
            }
        }

        valuesToRemove = newValuesToRemove;
    }

    int[16] result;

    for (int i = 0; i < digits.length; i++) {
        result[digits[i][0]] = i;
    }

    return result;
}

void main(string[] args) {
    int numEmptyLines = 0;
    State state = State.BEFORE;
    int[4] registerValues;
    int[4] beforeValues;
    int[4] commandToExecute;
    int[16] foundOpcodes;
    bool[16][16] possibleOpcodes;

    for (int assumedOpcode = 0; assumedOpcode < 16; assumedOpcode++) {
        for (int actualOpcode = 0; actualOpcode < 16; actualOpcode++) {
            possibleOpcodes[assumedOpcode][actualOpcode] = true;
        }
    }

    foreach (line; File(args[1]).byLine()) {
        if (numEmptyLines == 3) {
            foundOpcodes = findOpcodes(possibleOpcodes);
            state = state.EXEC;
        }

        if (line.length == 0) {
            numEmptyLines += 1;
            continue;
        } else {
            numEmptyLines = 0;
        }

        if (state == State.BEFORE) {
            beforeValues[0] = line[9] - 48;
            beforeValues[1] = line[12] - 48;
            beforeValues[2] = line[15] - 48;
            beforeValues[3] = line[18] - 48;
            state = State.ARGS;
        } else if (state == State.ARGS) {
            auto split = line.split(" ");
            commandToExecute[0] = to!int(split[0]);
            commandToExecute[1] = to!int(split[1]);
            commandToExecute[2] = to!int(split[2]);
            commandToExecute[3] = to!int(split[3]);
            state = State.AFTER;
        } else if (state == State.AFTER) {
            int[4] targetValues;
            int matchingCommands = 0;

            targetValues[0] = line[9] - 48;
            targetValues[1] = line[12] - 48;
            targetValues[2] = line[15] - 48;
            targetValues[3] = line[18] - 48;

            for (int opCode = 0; opCode < 16; opCode++) {
                int[4] tmpRegisters = executeCommand(beforeValues, opCode, commandToExecute[1], commandToExecute[2], commandToExecute[3]);

                if (targetValues[0] != tmpRegisters[0] ||
                    targetValues[1] != tmpRegisters[1] ||
                    targetValues[2] != tmpRegisters[2] ||
                    targetValues[3] != tmpRegisters[3]) {
                    possibleOpcodes[opCode][commandToExecute[0]] = false;
                }
            }

            state = State.BEFORE;
        } else if (state == State.EXEC) {
            auto split = line.split(" ");
            commandToExecute[0] = to!int(split[0]);
            commandToExecute[1] = to!int(split[1]);
            commandToExecute[2] = to!int(split[2]);
            commandToExecute[3] = to!int(split[3]);
            registerValues = executeCommand(registerValues, foundOpcodes[commandToExecute[0]], commandToExecute[1], commandToExecute[2], commandToExecute[3]);
        }
    }

    writeln(registerValues[0]);
}
