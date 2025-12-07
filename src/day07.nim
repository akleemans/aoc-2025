import math
import strutils
import benchy
import sequtils
import algorithm

let testData = """.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............""".splitLines()

proc printGrid(grid: seq[string]): void =
    for line in grid:
        echo line
    let line = readLine(stdin)

proc part1(data: seq[string]): int =
    var grid = data
    var splitCount = 0
    for r in 1..grid.len-1:
        var line = grid[r]
        for c in 0..line.len-1:
            if grid[r-1][c] == '|' or grid[r-1][c] == 'S':
                # Beam coming from above
                if line[c] == '.':
                    grid[r][c] = '|'
                elif line[c] == '^':
                    # Split beam
                    var beamsAdded = 0
                    if line[c-1] == '.':
                        grid[r][c-1] = '|'
                        beamsAdded += 1
                    if line[c+1] == '.':
                        grid[r][c+1] = '|'
                        beamsAdded += 1

                    if beamsAdded == 2:
                        splitCount += 1
        #printGrid(grid)

    #echo "splitCount: ", splitCount
    return splitCount

proc part2(data: seq[string]): int =
    var grid = data
    # Prepare countGrid
    var countGrid: seq[seq[int]] = @[]
    for line in data:
        countGrid.add(line.mapIt(0))

    for r in 1..grid.len-1:
        var line = grid[r]
        for c in 0..line.len-1:
            if grid[r-1][c] == '|' or grid[r-1][c] == 'S':
                var valueFromAbove = countGrid[r-1][c]
                if grid[r-1][c] == 'S':
                    valueFromAbove = 1

                # Beam coming from above
                if line[c] == '.':
                    grid[r][c] = '|'
                    countGrid[r][c] += valueFromAbove


                elif line[c] == '^':
                    # Left
                    countGrid[r][c-1] += valueFromAbove
                    grid[r][c-1] = '|'
                    #echo "Left: setting ", r, " ", c, " to ", countGrid[r][c-1]

                    # Right
                    countGrid[r][c+1] += valueFromAbove
                    grid[r][c+1] = '|'
                    #echo "Right: setting ", r, " ", c, " to ", countGrid[r][c+1]

        # printGrid(grid)

    # Count
    var splitCount = 0
    for count in countGrid[countGrid.len-1]:
        splitCount += count

    # echo "splitCount: ", splitCount
    return splitCount

proc main() =
    var data = strip(readFile("./inputs/day07.txt")).splitLines()

    let part1TestResult = part1(testData)
    doAssert part1TestResult == 21
    let part1Result = part1(data)
    doAssert part1Result == 1560

    let part2TestResult = part2(testData)
    doAssert part2TestResult == 40
    let part2Result = part2(data)
    doAssert part2Result == 25592971184998

timeIt "timeIt":
    main()