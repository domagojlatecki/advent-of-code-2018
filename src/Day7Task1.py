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

for step in allSteps:
    if step not in stepRequirements:
        availableSteps.append(step)

availableSteps = sorted(availableSteps)
stepSequence = ""

while len(availableSteps) != 0:
    step = availableSteps.pop(0)
    stepSequence += step
    newStepRequirements = {}

    for key in stepRequirements:
        value = stepRequirements[key]
        value.discard(step)

        if len(value) > 0:
            newStepRequirements[key] = value
        else:
            availableSteps.append(key)

    stepRequirements = newStepRequirements
    availableSteps = sorted(availableSteps)

print(stepSequence)
