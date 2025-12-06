import math
import strutils
import benchy
import sequtils
import algorithm

let testData = """123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  """.splitLines()


proc part1(data: seq[string]): int =
    # Collect problem statements as numbers
    var lines: seq[seq[int]] = @[]
    for i in 0 ..< data.len-1:
        let parts = strutils.splitWhitespace(data[i]).mapIt(parseInt(it))
        lines.add(parts)
    # echo "lines: ", lines
    
    let ops = strutils.splitWhitespace(data[data.len-1])
    # echo "ops: ", ops

    # Sum
    var grandTotal = 0
    for col in 0..lines[0].len-1:
        var problem: seq[int] = @[]
        for i in 0..lines.len-1:
            problem.add(lines[i][col])
        # echo "problem: ", problem

        let op = ops[col]
        if op == "*":
            grandTotal += problem.foldl(a * b)
        else:
            grandTotal += problem.foldl(a + b)

    # echo "grandTotal: ", grandTotal
    return grandTotal

proc part2(data: seq[string]): int =
    # Collect problem statements as numbers
    var cols: seq[string] = @[]
    for i in countdown(data[0].len-1, 0):
        var col = ""
        for lineIdx in 0..data.len-2:
            col.add(data[lineIdx][i])
        cols.add(col)
    #echo "cols: ", cols

    # Read & reverse operations
    var ops = strutils.splitWhitespace(data[data.len-1])
    ops.reverse()

    var opsId = 0
    var grandTotal = 0
    var temp: seq[int] = @[]
    for idx in 0..cols.len-1:
        let item = cols[idx].strip()
        # If empty item, collect what we have until now
        if item == "" or idx == cols.len-1:
            if temp.len != 0:
                if idx == cols.len-1:
                    temp.add(parseInt(item))
                let op = ops[opsId]
                var tempResult: int
                if op == "*":
                    tempResult = temp.foldl(a * b)
                else:
                    tempResult = temp.foldl(a + b)
                #echo "calculating ", temp, " with ", op
                #echo "tempResult: ", tempResult
                grandTotal += tempResult
                temp = @[]
                opsId += 1
        else:
            temp.add(parseInt(item))

    #echo "grandTotal: ", grandTotal
    return grandTotal


proc main() =
    var data = strip(readFile("./inputs/day06.txt")).splitLines()

    let part1TestResult = part1(testData)
    doAssert part1TestResult == 4277556
    let part1Result = part1(data)
    doAssert part1Result == 5873191732773

    let part2TestResult = part2(testData)
    doAssert part2TestResult == 3263827
    let part2Result = part2(data)
    doAssert part2Result == 11386445308378

timeIt "timeIt":
    main()

