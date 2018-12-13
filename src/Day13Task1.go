package main

import (
    "os"
    "fmt"
    "strings"
    "io/ioutil"
)

func nextDirection(oldDirection rune, turn rune) rune {
    if oldDirection == '>' {
        if turn == 'L' {
            return '^'
        } else if turn == 'R' {
            return 'v'
        }
    }

    if oldDirection == '<' {
        if turn == 'L' {
            return 'v'
        } else if turn == 'R' {
            return '^'
        }
    }

    if oldDirection == '^' {
        if turn == 'L' {
            return '<'
        } else if turn == 'R' {
            return '>'
        }
    }

    if oldDirection == 'v' {
        if turn == 'L' {
            return '>'
        } else if turn == 'R' {
            return '<'
        }
    }

    return oldDirection
}

func nextTurn(turn rune) rune {
    if turn == 'L' {
        return 'S'
    }

    if turn == 'S' {
        return 'R'
    }

    return 'L'
}

func goUp(carts [][]rune, turns [][]rune, moved [][]bool, x int, y int) (int, int, bool) {
    if carts[y - 1][x] != ' ' {
        return x, y - 1, true
    } else {
        moved[y - 1][x] = true
        carts[y - 1][x] = '^'
        turns[y - 1][x] = turns[y][x]
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 0, 0, false
    }
}

func goDown(carts [][]rune, turns [][]rune, moved [][]bool, x int, y int) (int, int, bool) {
    if carts[y + 1][x] != ' ' {
        return x, y + 1, true
    } else {
        moved[y + 1][x] = true
        carts[y + 1][x] = 'v'
        turns[y + 1][x] = turns[y][x]
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 0, 0, false
    }
}

func goLeft(carts [][]rune, turns [][]rune, moved [][]bool, x int, y int) (int, int, bool) {
    if carts[y][x - 1] != ' ' {
        return x - 1, y, true
    } else {
        moved[y][x - 1] = true
        carts[y][x - 1] = '<'
        turns[y][x - 1] = turns[y][x]
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 0, 0, false
    }
}

func goRight(carts [][]rune, turns [][]rune, moved [][]bool, x int, y int) (int, int, bool) {
    if carts[y][x + 1] != ' ' {
        return x + 1, y, true
    } else {
        moved[y][x + 1] = true
        carts[y][x + 1] = '>'
        turns[y][x + 1] = turns[y][x]
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 0, 0, false
    }
}

func main() {
    data, _ := ioutil.ReadFile(os.Args[1])
    lines := strings.Split(string(data), "\n")

    xMax := len(lines[0])
    yMax := len(lines)
    rails := make([][]rune, yMax)
    carts := make([][]rune, yMax)
    turns := make([][]rune, yMax)
    moved := make([][]bool, yMax)

    for y := 0; y < yMax; y++ {
       rails[y] = make([]rune, xMax)
       carts[y] = make([]rune, xMax)
       turns[y] = make([]rune, xMax)
       moved[y] = make([]bool, xMax)
    }

    for y, line := range lines {
        for x, pos := range line {
            if pos == '<' || pos == '>' {
                rails[y][x] = '-'
                carts[y][x] = pos
                turns[y][x] = 'L'
            } else if pos == '^' || pos == 'v' {
                rails[y][x] = '|'
                carts[y][x] = pos
                turns[y][x] = 'L'
            } else {
                rails[y][x] = pos
                carts[y][x] = ' '
                turns[y][x] = ' '
            }

            moved[y][x] = false
        }
    }

    var crashed = false
    var xCrash = 0
    var yCrash = 0

    for !crashed {
        for y := 0; y < yMax; y++ {
            for x := 0; x < xMax; x++ {
                moved[y][x] = false
            }
        }

        Outer:
        for y := 0; y < yMax; y++ {
            for x := 0; x < xMax; x++ {
                if carts[y][x] == ' ' || moved[y][x] {
                    continue
                }

                if rails[y][x] == '-' {
                    if carts[y][x] == '<' {
                        xCrash, yCrash, crashed = goLeft(carts, turns, moved, x, y)
                    } else if carts[y][x] == '>' {
                        xCrash, yCrash, crashed = goRight(carts, turns, moved, x, y)
                    }
                } else if rails[y][x] == '|' {
                    if carts[y][x] == '^' {
                        xCrash, yCrash, crashed = goUp(carts, turns, moved, x, y)
                    } else if carts[y][x] == 'v' {
                        xCrash, yCrash, crashed = goDown(carts, turns, moved, x, y)
                    }
                } else if rails[y][x] == '/' {
                    if carts[y][x] == '>' {
                        xCrash, yCrash, crashed = goUp(carts, turns, moved, x, y)
                    } else if carts[y][x] == 'v' {
                        xCrash, yCrash, crashed = goLeft(carts, turns, moved, x, y)
                    } else if carts[y][x] == '<' {
                        xCrash, yCrash, crashed = goDown(carts, turns, moved, x, y)
                    } else if carts[y][x] == '^' {
                        xCrash, yCrash, crashed = goRight(carts, turns, moved, x, y)
                    }
                } else if rails[y][x] == '\\' {
                    if carts[y][x] == '>' {
                        xCrash, yCrash, crashed = goDown(carts, turns, moved, x, y)
                    } else if carts[y][x] == 'v' {
                        xCrash, yCrash, crashed = goRight(carts, turns, moved, x, y)
                    } else if carts[y][x] == '<' {
                        xCrash, yCrash, crashed = goUp(carts, turns, moved, x, y)
                    } else if carts[y][x] == '^' {
                        xCrash, yCrash, crashed = goLeft(carts, turns, moved, x, y)
                    }
                } else if rails[y][x] == '+' {
                    carts[y][x] = nextDirection(carts[y][x], turns[y][x])
                    turns[y][x] = nextTurn(turns[y][x])

                    if carts[y][x] == '<' {
                        xCrash, yCrash, crashed = goLeft(carts, turns, moved, x, y)
                    } else if carts[y][x] == '>' {
                        xCrash, yCrash, crashed = goRight(carts, turns, moved, x, y)
                    } else if carts[y][x] == '^' {
                        xCrash, yCrash, crashed = goUp(carts, turns, moved, x, y)
                    } else if carts[y][x] == 'v' {
                        xCrash, yCrash, crashed = goDown(carts, turns, moved, x, y)
                    }
                }

                if crashed {
                    break Outer
                }
            }
        }
    }

    fmt.Print(xCrash)
    fmt.Print(",")
    fmt.Println(yCrash)
}
