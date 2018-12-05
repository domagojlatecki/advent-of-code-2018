func sameCharsInDifferentCase(a: Character, b: Character) -> Bool {
    return a != b && String(a).uppercased() == String(b).uppercased()
}

var polymer = Array(readLine()!)
var changed = true

while changed {
    changed = false

    var skip = false
    var newPolymer = ""

    for i in 0...(polymer.count - 2) {
        let current = polymer[i]
        let next = polymer[i + 1]

        if skip {
            skip = false
        } else if sameCharsInDifferentCase(a: current, b: next) {
            skip = true
            changed = true
        } else {
            newPolymer += String(current)
        }
    }

    if !skip {
        newPolymer += String(polymer[polymer.count - 1])
    }

    polymer = Array(newPolymer)
}

print(polymer.count)
