import math
import strutils
import benchy

let testData = """987654321111111
811111111111119
234234234234278
818181911112111""".splitLines()

# Printing - notice the "", not ''!
echo "Hello Nim"

# Concat two strings
var a = 4
var b = 2
echo $a & $

# Convert String to int
echo parseInt("123")

# Create list
var list_a: seq[int] = @[]
list_a.add(1)

# Map list & join
echo list_a.mapIt($it).join(",")

# Define custom type
type Pair = tuple[first: int, second: int]







proc part1(data: seq[string]): int =
    var total_joltage = 0
    for bank in data:
        var a = 0
        var a_idx = -1

        # First, find highest a
        for idx in 0..bank.len-1:
            var cand = parseInt($bank[idx])
            if cand > a:
                a = cand
                a_idx = idx

        # Then, find highes b
        var b = 0
        for idx in a_idx..bank.len-1:
            var cand = parseInt($bank[idx])
            if cand > b:
                b = cand

        var joltage = parseInt($a & $b)
        total_joltage += joltage
    echo total_joltage
    return total_joltage

proc part2(data: seq[string]): int =
    return 0

proc main() =
    var data = strip(readFile("./inputs/day03.txt")).splitLines()

    let part1TestResult = part1(testData)
    doAssert part1TestResult == 357
    let part1Result = part1(data)
    doAssert part1Result == 0

    let part2TestResult = part2(testData)
    doAssert part2TestResult == 0
    let part2Result = part2(data)
    doAssert part2Result == 0
main()

#timeIt "day02":
#    main()
