extends AbstractDay

func getTitle() -> String:
	return "Day 13: Transparent Origami"

func getInput():
	var lines = getInputAsLinesRaw()
	var points = []
	var pointRegex = RegEx.new()
	pointRegex.compile("(\\d+),(\\d+)")
	var i = 0
	for line in lines:
		if line == "":
			break;
		var result = pointRegex.search(line)
		points.append({
			"x": int(result.get_string(1)),
			"y": int(result.get_string(2)),
		})
		i += 1
	
	var folds = []
	var foldRegex = RegEx.new()
	foldRegex.compile("fold along (y|x)=(\\d+)")
	for j in range(i+1, lines.size()):
		var result = foldRegex.search(lines[j])
		folds.append({
			"dir": result.get_string(1),
			"value": int(result.get_string(2)),
		})

	return {"points": points, "folds": folds}

func calculatePart1() -> String:
	var tmp = getInput()
	var map = buidlMap(tmp["points"]) 
	var folds = tmp["folds"]
	map = foldMap(map, folds[0])
	return countPointsOnMap(map)

func calculatePart2() -> String:
	var tmp = getInput()
	var map = buidlMap(tmp["points"]) 
	var folds = tmp["folds"]
	
	for fold in folds:
		map = foldMap(map, fold)
	
	#printMap(map)
	return mapToText(map)

func mapToText(map) -> String:
	var text = ""
	var chars = {
		"####.#....###..#....#....#....": "F",
		"#..#.#..#.####.#..#.#..#.#..#.": "H",
		"..##....#....#....#.#..#..##..": "J",
		"###..#..#.#..#.###..#....#....": "P",
		"###..#..#.#..#.###..#.#..#..#.": "R",
		"####....#...#...#...#....####.": "Z",
	}
	for i in range(0, 8):
		var sub = subArray(map, i*5, 0, 5, 6)
		text += chars[linearTextMap(sub)]
	return text

func foldMap(map, fold):
	if fold["dir"] == "x": return foldMapLeft(map, fold["value"])
	elif fold["dir"] == "y": return foldMapUp(map, fold["value"])

func foldMapLeft(map, newWidth):
	var newHeight = map.size()
	var newMap = Utility.fill_array2d(newWidth, newHeight)
	copyMap(map, newMap)
	for y in range(0, map.size()):
		var newX = 0
		for x in range(map[y].size() -1, newWidth, -1):
			newMap[y][newX] += map[y][x]
			newX += 1
	return newMap

func foldMapUp(map, newHeight):
	var newWidth = map[0].size()
	var newMap = Utility.fill_array2d(newWidth, newHeight)
	copyMap(map, newMap)
	var newY = 0
	for y in range(map.size() -1, newHeight, -1):
		for x in range(0, map[y].size()):
			newMap[newY][x] += map[y][x]
		newY += 1
	return newMap

func copyMap(map, newMap):
	for y in range(0, newMap.size()):
		for x in range(0, newMap[y].size()):
			newMap[y][x] = map[y][x]

func subArray(map, x, y, width, height):
	var result = Utility.fill_array2d(width, height)
	var newY = 0
	for py in range(y, y+height):
		var newX = 0
		for px in range(x, x+width):
			result[newY][newX] = map[py][px]
			newX += 1
		newY += 1
	return result

func buidlMap(points) -> Array:
	var minMax = getMinMax(points)
	var map = Utility.fill_array2d(minMax["maxX"]+1, minMax["maxY"]+1)
	for point in points:
		map[point["y"]][point["x"]] = 1
	return map

func getMinMax(points):
	var minMax = {
		"minX": points[0]["x"],
		"maxX": points[0]["x"],
		"minY": points[0]["y"],
		"maxY": points[0]["y"]
	}
	for point in points:
		if minMax["minX"] > point["x"]: minMax["minX"] = point["x"]
		if minMax["minY"] > point["y"]: minMax["minY"] = point["y"]
		if minMax["maxX"] < point["x"]: minMax["maxX"] = point["x"]
		if minMax["maxY"] < point["y"]: minMax["maxY"] = point["y"]
	return minMax

func countPointsOnMap(map):
	var count = 0
	for row in map:
		for col in row:
			if col > 0:
				count += 1
	return count

func printMap(map):
	for row in map:
		var line = ""
		for col in row:
			if col > 0:
				line += "#"
			else:
				line += "."
		print(line)

func linearTextMap(map):
	var text = ""
	for row in map:
		for col in row:
			if col > 0:
				text += "#"
			else:
				text += "."
	return text
