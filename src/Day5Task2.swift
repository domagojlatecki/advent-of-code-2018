func sameCharsInDifferentCase(a: Character, b: Character) -> Bool {
    return a != b && String(a).uppercased() == String(b).uppercased()
}

func polymerLength(poly: Array<Character>) -> Int {
    var polymer = poly
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

    return polymer.count
}

let input = readLine()!
let allChars = Array("abcdefghijklmnopqrstuvwxyz")
var minLength = input.count

for toRemove in allChars {
    var poly = ""

    for c in input {
        if (String(toRemove) != String(c).lowercased()) {
            poly += String(c)
        }
    }

    let length = polymerLength(poly: Array(poly))

    if length < minLength {
        minLength = length
    }
}

print(minLength)
