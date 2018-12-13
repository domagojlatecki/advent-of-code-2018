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

func goUp(carts [][]rune, turns [][]rune, moved [][]bool, x int, y int) int {
    if carts[y - 1][x] != ' ' {
        moved[y - 1][x] = false
        carts[y - 1][x] = ' '
        turns[y - 1][x] = ' '
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 2
    } else {
        moved[y - 1][x] = true
        carts[y - 1][x] = '^'
        turns[y - 1][x] = turns[y][x]
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 0
    }
}

func goDown(carts [][]rune, turns [][]rune, moved [][]bool, x int, y int) int {
    if carts[y + 1][x] != ' ' {
        moved[y + 1][x] = false
        carts[y + 1][x] = ' '
        turns[y + 1][x] = ' '
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 2
    } else {
        moved[y + 1][x] = true
        carts[y + 1][x] = 'v'
        turns[y + 1][x] = turns[y][x]
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 0
    }
}

func goLeft(carts [][]rune, turns [][]rune, moved [][]bool, x int, y int) int {
    if carts[y][x - 1] != ' ' {
        moved[y][x - 1] = false
        carts[y][x - 1] = ' '
        turns[y][x - 1] = ' '
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 2
    } else {
        moved[y][x - 1] = true
        carts[y][x - 1] = '<'
        turns[y][x - 1] = turns[y][x]
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 0
    }
}

func goRight(carts [][]rune, turns [][]rune, moved [][]bool, x int, y int) int {
    if carts[y][x + 1] != ' ' {
        moved[y][x + 1] = false
        carts[y][x + 1] = ' '
        turns[y][x + 1] = ' '
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 2
    } else {
        moved[y][x + 1] = true
        carts[y][x + 1] = '>'
        turns[y][x + 1] = turns[y][x]
        carts[y][x] = ' '
        turns[y][x] = ' '
        moved[y][x] = false
        return 0
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

    var numRemainingCarts = 0

    for y, line := range lines {
        for x, pos := range line {
            if pos == '<' || pos == '>' {
                rails[y][x] = '-'
                carts[y][x] = pos
                turns[y][x] = 'L'
                numRemainingCarts += 1
            } else if pos == '^' || pos == 'v' {
                rails[y][x] = '|'
                carts[y][x] = pos
                turns[y][x] = 'L'
                numRemainingCarts += 1
            } else {
                rails[y][x] = pos
                carts[y][x] = ' '
                turns[y][x] = ' '
            }

            moved[y][x] = false
        }
    }

    for numRemainingCarts > 1 {
        for y := 0; y < yMax; y++ {
            for x := 0; x < xMax; x++ {
                moved[y][x] = false
            }
        }

        for y := 0; y < yMax; y++ {
            for x := 0; x < xMax; x++ {
                if carts[y][x] == ' ' || moved[y][x] {
                    continue
                }

                if rails[y][x] == '-' {
                    if carts[y][x] == '<' {
                        numRemainingCarts -= goLeft(carts, turns, moved, x, y)
                    } else if carts[y][x] == '>' {
                        numRemainingCarts -= goRight(carts, turns, moved, x, y)
                    }
                } else if rails[y][x] == '|' {
                    if carts[y][x] == '^' {
                        numRemainingCarts -= goUp(carts, turns, moved, x, y)
                    } else if carts[y][x] == 'v' {
                        numRemainingCarts -= goDown(carts, turns, moved, x, y)
                    }
                } else if rails[y][x] == '/' {
                    if carts[y][x] == '>' {
                        numRemainingCarts -= goUp(carts, turns, moved, x, y)
                    } else if carts[y][x] == 'v' {
                        numRemainingCarts -= goLeft(carts, turns, moved, x, y)
                    } else if carts[y][x] == '<' {
                        numRemainingCarts -= goDown(carts, turns, moved, x, y)
                    } else if carts[y][x] == '^' {
                        numRemainingCarts -= goRight(carts, turns, moved, x, y)
                    }
                } else if rails[y][x] == '\\' {
                    if carts[y][x] == '>' {
                        numRemainingCarts -= goDown(carts, turns, moved, x, y)
                    } else if carts[y][x] == 'v' {
                        numRemainingCarts -= goRight(carts, turns, moved, x, y)
                    } else if carts[y][x] == '<' {
                        numRemainingCarts -= goUp(carts, turns, moved, x, y)
                    } else if carts[y][x] == '^' {
                        numRemainingCarts -= goLeft(carts, turns, moved, x, y)
                    }
                } else if rails[y][x] == '+' {
                    carts[y][x] = nextDirection(carts[y][x], turns[y][x])
                    turns[y][x] = nextTurn(turns[y][x])

                    if carts[y][x] == '<' {
                        numRemainingCarts -= goLeft(carts, turns, moved, x, y)
                    } else if carts[y][x] == '>' {
                        numRemainingCarts -= goRight(carts, turns, moved, x, y)
                    } else if carts[y][x] == '^' {
                        numRemainingCarts -= goUp(carts, turns, moved, x, y)
                    } else if carts[y][x] == 'v' {
                        numRemainingCarts -= goDown(carts, turns, moved, x, y)
                    }
                }
            }
        }
    }

    for y := 0; y < yMax; y++ {
        for x := 0; x < xMax; x++ {
            if carts[y][x] == '^' || carts[y][x] == 'v' || carts[y][x] == '<' || carts[y][x] == '>' {
                fmt.Print(x)
                fmt.Print(",")
                fmt.Println(y)
            }
        }
    }
}
