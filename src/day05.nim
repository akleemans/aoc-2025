import math
import strutils
import benchy
import sequtils
import algorithm

let testData = """3-5
10-14
16-20
12-18

1
5
8
11
17
32""".splitLines()


proc part1(data: seq[string]): int =
    var count = 0
    var rangeMode = true
    var ranges: seq[tuple[first: int, second: int]] = @[]
    for line in data:
        if line.len == 0:
            rangeMode = false
            continue
        if rangeMode:
            #echo "parsing range ", line
            let r = line.split('-').mapIt(parseInt(it))
            ranges.add((r[0], r[1]))
        else:
            let n = parseInt(line)
            for r in ranges:
                if n >= r[0] and n <= r[1]:
                    #echo "n=", n, " is fresh"
                    count += 1
                    break
    #echo count
    return count

proc part2(data: seq[string]): int =
    var ranges: seq[tuple[first: int, second: int]] = @[]
    for line in data:
        if line.len == 0:
            break
        let r = line.split('-').mapIt(parseInt(it))
        ranges.add((r[0], r[1]))
    
    let sortedRanges = ranges.sortedByIt(it.first)

    # Process ranges
    var uniqueRanges: seq[tuple[first: int, second: int]] = @[]
    for r in sortedRanges:
        var merged = false
        for idx in 0..uniqueRanges.len-1:
            var ur = uniqueRanges[idx]
            # If start value lies within an already known range, extend it
            if r[0] >= ur[0] and r[0] <= ur[1]:
                #echo "merging ", r
                uniqueRanges[idx][1] = max(uniqueRanges[idx][1], r[1])
                #echo "new range: ", uniqueRanges[idx]
                merged = true
                break
        if not merged:
            uniqueRanges.add(r)

    # Count ranges
    var count = 0
    for r in uniqueRanges:
        #echo "counting range: ", r
        count += r[1] - r[0] + 1
    #echo count
    return count

proc main() =
    var data = strip(readFile("./inputs/day05.txt")).splitLines()

    let part1TestResult = part1(testData)
    doAssert part1TestResult == 3
    let part1Result = part1(data)
    doAssert part1Result == 888

    let part2TestResult = part2(testData)
    doAssert part2TestResult == 14
    let part2Result = part2(data)
    doAssert part2Result == 344378119285354


timeIt "day02":
    main()
