extends AbstractDay

func getTitle() -> String:
	return "Day 3: Binary Diagnostic"

func calculatePart1():
	var lines = getInputAsLines()
	var majority = (lines.size() / 2) + 1
	if majority % 2 == 0:
		majority += 1
	var values = []
	for i in lines[0].length():
		values.append(0)
	for i in range(0, lines.size()):
		var j = 0
		for c in lines[i]:
			if c == "1":
				values[j] += 1
			j += 1
	
	var gamma = ""
	var epsilon = ""
	for v in values:
		if v >= majority:
			gamma += "1"
			epsilon += "0"
		else:
			gamma += "0"
			epsilon += "1"
		
	return Utility.bin2int(gamma) * Utility.bin2int(epsilon)
	
func calculatePart2():
	return ""
