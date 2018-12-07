import sys
import re

allSteps = set([])
stepRequirements = {}

for line in open(sys.argv[1]).readlines():
    match = re.match("Step (.) must be finished before step (.) can begin.", line)
    requirement = match.group(1)
    step = match.group(2)
    allSteps.add(requirement)
    allSteps.add(step)

    if step not in stepRequirements:
        stepRequirements[step] = set([])

    stepRequirements[step].add(requirement)

availableSteps = []
remainingStepTimes = {}
alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

for step in allSteps:
    remainingStepTimes[step] = 61 + alphabet.index(step)

    if step not in stepRequirements:
        availableSteps.append(step)

availableSteps = sorted(availableSteps)
time = 0

while len(availableSteps) != 0:
    stepCompleted = False

    while not stepCompleted:
        time += 1

        for i in range(0, min(len(availableSteps), 5)):
            remainingStepTimes[availableSteps[i]] -= 1

            if remainingStepTimes[availableSteps[i]] == 0:
                stepCompleted = True

    newAvailableSteps = []
    completedSteps = []

    for step in availableSteps:
        if remainingStepTimes[step] > 0:
            newAvailableSteps.append(step)
        else:
            completedSteps.append(step)

    newStepRequirements = {}
    freedSteps = []

    for completedStep in completedSteps:
        for key in stepRequirements:
            value = stepRequirements[key]
            value.discard(completedStep)

            if len(value) > 0:
                newStepRequirements[key] = value
            else:
                freedSteps.append(key)

    stepRequirements = newStepRequirements
    freedSteps = sorted(freedSteps)
    availableSteps = newAvailableSteps + freedSteps

print(time)
