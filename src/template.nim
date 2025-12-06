import math
import strutils
import benchy
import sequtils
import algorithm

let testData = """""".splitLines()


proc part1(data: seq[string]): int =
    return 0

proc part2(data: seq[string]): int =
    return 0

proc main() =
    var data = strip(readFile("./inputs/day00.txt")).splitLines()

    let part1TestResult = part1(testData)
    doAssert part1TestResult == -1
    let part1Result = part1(data)
    doAssert part1Result == -1

    let part2TestResult = part2(testData)
    doAssert part2TestResult == -1
    let part2Result = part2(data)
    doAssert part2Result == -1

main()

