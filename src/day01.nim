import strutils
import algorithm
import sequtils
import benchy

let testData = """L68
L30
R48
L5
R60
L55
L1
L99
R14
L82""".splitLines()

proc part1(data: seq[string]): int =
    var dial = 50
    var pw = 0
    for line in data:
        var dir = line[0] # L or R
        var amount = parseInt(line[1..line.len-1])
        if dir == 'R':
            dial = (dial + amount) mod 100
        if dir == 'L':
            dial = (dial - amount + 100) mod 100
        if dial == 0:
            pw += 1
    return pw

proc part2(data: seq[string]): int =
    var dial = 50
    var pw = 0
    for line in data:
        var dir = line[0] # L or R
        var amount = parseInt(line[1..line.len-1])
        
        # Had some weird error, just trying it one for one for now
        for i in 1..amount:
            if dir == 'R':
                dial += 1
            elif dir == 'L':
                dial -= 1

            if dial == 100:
                dial = 0
            elif dial == -1:
                dial = 99

            if dial == 0:
                pw += 1
    return pw

proc main() =
    var data = strip(readFile("./inputs/day01.txt")).splitLines()

    let part1TestResult = part1(testData)
    doAssert part1TestResult == 3
    let part1Result = part1(data)
    doAssert part1Result == 964

    let part2TestResult = part2(testData)
    doAssert part2TestResult == 6
    let part2Result = part2(data)
    doAssert part2Result == 5872

main()

timeIt "day01":
    main()
