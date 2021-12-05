extends AbstractDay

func getTitle() -> String:
	return "Day 3: Binary Diagnostic"

func calculatePart1():
	var lines = getInputAsLines()
	var majority = (lines.size() / 2) + 1
	if majority % 2 == 0:
		majority += 1
	var values = Utility.fill_array(lines[0].length())
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
	var lines = getInputAsLines()
	
	var majorityLines = PoolStringArray(lines)
	var position = 0
	while majorityLines.size() > 1:
		majorityLines = filterLinesMajority(majorityLines, position)
		position += 1
	
	var minorityLines = PoolStringArray(lines)
	position = 0
	while minorityLines.size() > 1:
		minorityLines = filterLinesMinority(minorityLines, position)
		position += 1

	return Utility.bin2int(majorityLines[0]) * Utility.bin2int(minorityLines[0])

func filterLinesMajority(lines, position):
	var filteredLines = []
	var majorityChar = getMajorityChar(lines, position)
	
	for line in lines:
		if majorityChar == line[position]:
			filteredLines.append(line)
	
	return filteredLines

func filterLinesMinority(lines, position):
	var filteredLines = []
	var majorityChar = getMajorityChar(lines, position)
	
	for line in lines:
		if majorityChar != line[position]:
			filteredLines.append(line)
	
	return filteredLines

func getMajorityChar(lines, position):
	var count1 = 0
	var count0 = 0
	for i in range(0, lines.size()):
		if lines[i][position] == "1":
			count1 += 1
		else:
			count0 += 1
	if count1 >= count0:
		return "1"
	return "0"
