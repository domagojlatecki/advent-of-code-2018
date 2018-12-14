#include <stdlib.h>
#include <iostream>

using namespace std;

int main(int argc, char* argv[]) {
    char *requestedPrefix = argv[1];
    int prefixLenght = strlen(requestedPrefix);
    int currentSize = 128;
    char *recipes = new char[currentSize];

    recipes[0] = 3;
    recipes[1] = 7;

    int numMade = 2;
    int elf1 = 0;
    int elf2 = 1;
    int checkFrom = 0;
    bool found = false;

    while (!found) {
        int newRecipe = recipes[elf1] + recipes[elf2];

        if (numMade + 2 > currentSize) {
            char *newArray = new char[currentSize * 2];

            for (int i = 0; i< currentSize; i++) {
                newArray[i] = recipes[i];
            }

            delete [] recipes;
            currentSize *= 2;
            recipes = newArray;
        }

        if (newRecipe < 10) {
            recipes[numMade] = newRecipe;
            numMade += 1;
        } else {
            recipes[numMade] = newRecipe / 10;
            recipes[numMade + 1] = newRecipe % 10;
            numMade += 2;
        }

        elf1 = (elf1 + recipes[elf1] + 1) % numMade;
        elf2 = (elf2 + recipes[elf2] + 1) % numMade;

        while (checkFrom + prefixLenght <= numMade) {
            found = true;

            for (int i = 0; i < prefixLenght; i++) {
                if ((requestedPrefix[i] - 48) != recipes[i + checkFrom]) {
                    found = false;
                    checkFrom += 1;
                    break;
                }
            }

            if (found) {
                break;
            }
        }
    }

    cout << checkFrom << endl;
}
