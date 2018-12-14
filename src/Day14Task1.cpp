#include <stdlib.h>
#include <iostream>

using namespace std;

int main(int argc, char* argv[]) {
    int requestedNumOfRecipes = atoi(argv[1]);
    char *recipes = new char[requestedNumOfRecipes + 20];

    recipes[0] = 3;
    recipes[1] = 7;

    int numMade = 2;
    int elf1 = 0;
    int elf2 = 1;

    while (numMade < requestedNumOfRecipes + 10) {
        int newRecipe = recipes[elf1] + recipes[elf2];

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
    }

    for (int i = requestedNumOfRecipes; i < requestedNumOfRecipes + 10; i++) {
        cout << +recipes[i];
    }

    cout << endl;
}
