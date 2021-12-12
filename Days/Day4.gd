extends AbstractDay

func getTitle() -> String:
	return "Day 4: Giant Squid"

func getInput():
	var lines = puzzleInput.text.split("\n")
	var numbers = []
	for n in lines[0].split(",", false):
		numbers.append(int(n))
	var bingoFields = []
	var currentField = []
	for l in range(2, lines.size()):
		if lines[l] == "":
			bingoFields.append(currentField)
			currentField = []
			continue
		var rowRaw = lines[l].split(" ", false)
		var row = []
		for r in rowRaw:
			row.append({"value": int(r), "on": false})
		currentField.append(row)
	bingoFields.append(currentField)
	return {"numbers": numbers, "fields": bingoFields}

func calculatePart1():
	var tmp = getInput()
	var numbers = tmp["numbers"]
	var fields = tmp["fields"]
	
	for n in numbers:
		for field in fields:
			if markField(field, n):
				if hasBingo(field):
					return sumBingoScore(field) * n
	return "no solution found"
	
func calculatePart2():
	var tmp = getInput()
	var numbers = tmp["numbers"]
	var fields = tmp["fields"]
	
	for n in numbers:
		var i = 0
		var fieldsToRemove = []
		for field in fields:
			if markField(field, n):
				if hasBingo(field):
					fieldsToRemove.append(i)
			i += 1
			
		fieldsToRemove.invert()
		for f in fieldsToRemove:
			var lastField = fields.pop_at(f)
			if fields.size() == 0:
				return sumBingoScore(lastField) * n
	return "no solution found"

func markField(field, n):
	for y in range(0, field.size()):
		for x in range(0, field[y].size()):
			if field[y][x]["value"] == n:
				field[y][x]["on"] = true
				return true
	return false

func hasBingo(field):
	var colSize = field.size()
	var rowSize = field[0].size()
	for y in range(0, colSize):
		var rowCount = 0
		for x in range(0, rowSize):
			if field[y][x]["on"]:
				rowCount += 1
		if rowCount == rowSize:
			return true
	
	for x in range(0, rowSize):
		var colCount = 0
		for y in range(0, colSize):
			if field[y][x]["on"]:
				colCount += 1
		if colCount == colSize:
			return true
	return false
	
func sumBingoScore(field):
	var score = 0
	for y in range(0, field.size()):
		for x in range(0, field[y].size()):
			if !field[y][x]["on"]:
				score += field[y][x]["value"]
	return score
