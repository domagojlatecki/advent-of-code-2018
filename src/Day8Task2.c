#include <stdio.h>
#include <stdlib.h>

struct Node {
    int numChildren;
    int numMetadata;
    struct Node *children;
    int *metadata;
};

int buildTree(int *data, int currentIndex, struct Node *currentNode) {
    int index = currentIndex;

    currentNode->numChildren = data[index];
    currentNode->numMetadata = data[index + 1];
    index += 2;

    int i;

    if (currentNode->numChildren > 0) {
        currentNode->children = (struct Node*) malloc(sizeof(struct Node) * currentNode->numChildren);

        for (i = 0; i < currentNode->numChildren; i++) {
            index = buildTree(data, index, &currentNode->children[i]);
        }
    }

    if (currentNode->numMetadata > 0) {
        currentNode->metadata = (int*) malloc(sizeof(int) * currentNode->numMetadata);

        for (i = 0; i < currentNode->numMetadata; i++) {
            currentNode->metadata[i] = data[index];
            index += 1;
        }
    }

    return index;
}

int nodeValue(struct Node *node) {
    int i;
    int sum = 0;

    if (node->numChildren == 0) {
        for (i = 0; i < node->numMetadata; i++) {
            sum += node->metadata[i];
        }
    } else {
        for (i = 0; i < node->numMetadata; i++) {
            int childIndex = node->metadata[i] - 1;

            if (childIndex >= 0 && childIndex < node->numChildren) {
                sum += nodeValue(&node->children[childIndex]);
            }
        }
    }

    return sum;
}

int main(int argc, char *argv[]) {
    int i;
    int *numbers = (int*) malloc(sizeof(int) * (argc - 1));

    for (i = 1; i < argc; i++) {
        numbers[i - 1] = atoi(argv[i]);
    }

    struct Node *root = (struct Node*) malloc(sizeof(struct Node));
    buildTree(numbers, 0, root);
    int sum = nodeValue(root);

    printf("%d\n", sum);

    return 0;
}
