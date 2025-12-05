import math
import strutils
import benchy


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


