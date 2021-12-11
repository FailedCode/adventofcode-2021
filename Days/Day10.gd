extends AbstractDay

var illegalCharTable = {
	")": 3,
	"]": 57,
	"}": 1197,
	">": 25137,
}
var autocompleteCharTable = {
	"(": 1,
	"[": 2,
	"{": 3,
	"<": 4,
}
var openBracket = ["(", "[", "{", "<"]
var matchedBracket = {
	")":"(", 
	"]":"[",
	"}":"{",
	">":"<",
}

func getTitle() -> String:
	return "Day 10: Syntax Scoring"

func calculatePart1():
	var lines = getInputAsLines()
	var points = 0
	for line in lines:
		var c = firstIllegalChar(line)
		if c != null:
			points += illegalCharTable[c]
	return points

func calculatePart2():
	var lines = getInputAsLines()
	var incompleteLines = []
	for line in lines:
		var c = firstIllegalChar(line)
		if c == null:
			incompleteLines.append(line)
	
	var scores = []
	for line in incompleteLines:
		var points = autocompletePoints(line)
		scores.append(points)
	scores.sort()
	return scores[scores.size() / 2]

func firstIllegalChar(line):
	var openChar = []
	for c in line:
		if c in openBracket:
			openChar.append(c)
		else:
			if openChar.pop_back() != matchedBracket[c]:
				return c
	return null

func autocompletePoints(line):
	var openChar = []
	for c in line:
		if c in openBracket:
			openChar.append(c)
		else:
			openChar.pop_back()
	
	var pointsTotal = 0
	while !openChar.empty():
		var c = openChar.pop_back()
		pointsTotal *= 5
		pointsTotal += autocompleteCharTable[c]
	return pointsTotal
