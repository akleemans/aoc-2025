import math
import strutils
import benchy


# Printing - notice the "", not ''!
echo "Hello Nim"

# Varables and constants
var canChangeCounter = 0
let fixedVar = 42

# Concat two strings
var a = 4
var b = 2
echo $a & $

# Convert String to int
echo parseInt("123")

# Create list
var list_a: seq[int] = @[]
list_a.add(1)
list_a.add(2)

# Split with lots of whitespace
let parts = strutils.splitWhitespace("23  43    1")

# Map list & join
echo list_a.mapIt($it).join(",")

# Reduce sequence (sum, etc.)
echo list_a.foldl(a + b)

# Reverse sequence
list_a.reverse()
echo "Reversed list: ", list_a

# Define custom type
type Pair = tuple[first: int, second: int]

# Count down
for i in countdown(4, 0):
    echo i

# Wait for input
let line = readLine(stdin)
echo "You wrote ", line