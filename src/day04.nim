import math
import strutils
import benchy
import sequtils

let testData = """..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.""".splitLines()


proc `+`(a: (int, int), b: (int, int)): (int, int) =
    (a[0]+b[0], a[1]+b[1])

proc inBounds(pos: (int, int), w: int, h: int): bool =
    return pos[0] >= 0 and pos[1] >= 0 and pos[0] >= 0 and pos[0] < h and pos[1] < w

proc countAround(pos: (int, int), data: seq[string]): int =
    var h = data.len
    var w = data[0].len
    var count = 0

    for r in -1..1:
        for c in -1..1:
            var new_pos = pos + (r, c)
            if new_pos != pos and inBounds(new_pos, w, h) and data[new_pos[0]][new_pos[1]] == '@':
                count += 1
    return count
            

proc part1(data: seq[string]): int =
    var rolls = 0
    for r in 0..data.len-1:
        var row = data[r]
        for c in 0..row.len-1:
            if data[r][c] == '@' and countAround((r, c), data) < 4:
                rolls += 1
    return rolls

proc part2(dataOrig: seq[string]): int =
    var data = dataOrig.mapIt(it)
    var rolls_removed = 0

    # Keep removing paper rolls until there's no change
    var doAgain = true
    while doAgain:
        doAgain = false
        for r in 0..data.len-1:
            var row = data[r]
            for c in 0..row.len-1:
                if data[r][c] == '@' and countAround((r, c), data) < 4:
                    data[r][c] = '.'
                    rolls_removed += 1
                    doAgain = true

    return rolls_removed

proc main() =
    var data = strip(readFile("./inputs/day04.txt")).splitLines()

    let part1TestResult = part1(testData)
    doAssert part1TestResult == 13
    let part1Result = part1(data)
    doAssert part1Result == 1441

    let part2TestResult = part2(testData)
    doAssert part2TestResult == 43
    let part2Result = part2(data)
    doAssert part2Result == 9050


timeIt "day02":
    main()
