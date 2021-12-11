extends AbstractDay

var illegalCharTable = {
	")": 3,
	"]": 57,
	"}": 1197,
	">": 25137,
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

func firstIllegalChar(line):
	var openChar = []
	for c in line:
		if c in openBracket:
			openChar.append(c)
		else:
			if openChar.pop_back() != matchedBracket[c]:
				return c
	return null
