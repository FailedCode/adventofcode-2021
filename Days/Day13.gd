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
