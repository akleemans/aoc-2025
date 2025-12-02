import math
import strutils
import benchy

let testData = """11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124""".splitLines()

proc part1(data: seq[string]): int =
    var ranges = data[0].split(",")
    var invalid_sum = 0
    for product_range in ranges:
        var parts = product_range.split('-')
        var a = parseInt(parts[0])
        var b = parseInt(parts[1])
        for i in a..b:
            var id_string = $i
            var l = int(floor(id_string.len/2))
            if id_string[0..l-1] == id_string[l..id_string.len-1]:
                invalid_sum += i
    return invalid_sum

proc part2(data: seq[string]): int =
    var ranges = data[0].split(",")
    var invalid_sum = 0
    for product_range in ranges:
        var parts = product_range.split('-')
        var a = parseInt(parts[0])
        var b = parseInt(parts[1])
        for i in a..b:
            var id_string = $i

            # Check for possible lengths of repeating sequence
            for l in 1..int(floor(id_string.len/2)):

                # Calculate amount of repititions r
                var r = int(floor(id_string.len/l))
                if l*r != id_string.len:
                    # For example l=2 with word length 5
                    continue
                #echo "working on ", i, " with l=", l, ", r=", r
                
                var match_possible = true
                for r_i in 0..r-2:
                    #echo "r_i=", r_i
                    var a_from = r_i*l
                    var a_to = ((r_i+1)*l)-1
                    var b_from = (r_i+1)*l
                    var b_to = ((r_i+2)*l)-1
                    
                    if id_string[a_from..a_to] != id_string[b_from..b_to]:
                        match_possible = false
                        break

                if match_possible:
                    #echo "found invalid for ", i, " l=", l, " r=", r
                    invalid_sum += i
                    break

    #echo invalid_sum
    return invalid_sum

proc main() =
    var data = strip(readFile("../inputs/day02.txt")).splitLines()

    let part1TestResult = part1(testData)
    doAssert part1TestResult == 1227775554
    let part1Result = part1(data)
    doAssert part1Result == 26255179562

    let part2TestResult = part2(testData)
    doAssert part2TestResult == 4174379265
    let part2Result = part2(data)
    doAssert part2Result == 31680313976

timeIt "day02":
    main()
