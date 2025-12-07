import math
import strutils
import benchy
import sequtils, strutils

let testData = """987654321111111
811111111111119
234234234234278
818181911112111""".splitLines()

proc part1(data: seq[string]): int =
    var total_joltage = 0
    for bank in data:
        var a = 0
        var a_idx = -1

        # First, find highest a
        for idx in 0..bank.len-2:
            var cand = parseInt($bank[idx])
            if cand > a:
                a = cand
                a_idx = idx

        # Then, find highes b
        var b = 0
        for idx in (a_idx+1)..bank.len-1:
            var cand = parseInt($bank[idx])
            if cand > b:
                b = cand

        var joltage = parseInt($a & $b)
        # echo "joltage: ", joltage
        total_joltage += joltage
    # echo total_joltage
    return total_joltage

proc part2(data: seq[string]): int =
    var total_joltage = 0
    for bank in data:
        var joltages: seq[int] = @[]

        var last_idx = -1
        for i in 0..11:
            var a = 0

            # Find highest a
            for idx in (last_idx+1)..bank.len-(12-i):
                var cand = parseInt($bank[idx])
                if cand > a:
                    a = cand
                    last_idx = idx
            joltages.add(a)

        var joltage = parseInt(joltages.mapIt($it).join(""))
        #echo "joltage: ", joltage
        total_joltage += joltage
        
    #echo total_joltage
    return total_joltage

proc main() =
    var data = strip(readFile("./inputs/day03.txt")).splitLines()

    let part1TestResult = part1(testData)
    doAssert part1TestResult == 357
    let part1Result = part1(data)
    doAssert part1Result == 17301

    let part2TestResult = part2(testData)
    doAssert part2TestResult == 3121910778619
    let part2Result = part2(data)
    doAssert part2Result == 172162399742349


timeIt "timeIt":
    main()
