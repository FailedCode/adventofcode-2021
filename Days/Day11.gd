extends AbstractDay

func getTitle() -> String:
	return "Day 11: Dumbo Octopus"

func getInputArray():
	var lines = getInputAsLines()
	var numbers = []
	for line in lines:
		var row = []
		for c in line:
			row.append(int(c))
		numbers.append(row)
	return numbers
	
func calculatePart1():
	var octopuses = getInputArray()
	var flashes = 0
	for i in range(0, 100):
		flashes += calcOctopuses(octopuses)
	return flashes

func calcOctopuses(octopuses):
	for row in range(0, octopuses.size()):
		for col in range(0, octopuses[row].size()):
			octopuses[row][col] += 1

	var flashesSum = 0
	while(true):
		var flashes = calcFlashes(octopuses)
		flashesSum += flashes
		if flashes == 0:
			break;

	return flashesSum

func calcFlashes(octopuses):
	var flashes = 0
	for row in range(0, octopuses.size()):
		for col in range(0, octopuses[row].size()):
			if octopuses[row][col] > 9:
				octopuses[row][col] = 0
				flashes += 1
				for y in [row-1, row, row+1]:
					for x in [col-1, col, col+1]:
						if y == row && x == col:
							continue
						if y < 0 || y >= octopuses.size():
							continue
						if x < 0 || x >= octopuses[row].size():
							continue
						if octopuses[y][x] == 0:
							continue
						octopuses[y][x] += 1
	return flashes
