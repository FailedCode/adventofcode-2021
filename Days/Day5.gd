extends AbstractDay

func getTitle() -> String:
	return "Day 5: Hydrothermal Venture"

func getInput():
	var result = []
	var regex = RegEx.new()
	regex.compile("(\\d+),(\\d+)\\s->\\s(\\d+),(\\d+)")
	var lines = getInputAsLines()
	for l in lines:
		var points = regex.search(l)
		result.append({
			"x1": int(points.get_string(1)),
			"y1": int(points.get_string(2)),
			"x2": int(points.get_string(3)),
			"y2": int(points.get_string(4)),
		})
	return result

func calculatePart1():
	var lines = getInput()
	var minMax = getMinMax(lines)
	var map = Utility.fill_array2d(minMax["maxX"], minMax["maxY"])
	for line in lines:
		if line["x1"] == line["x2"]:
			for i in range(min(line["y1"], line["y2"]), max(line["y1"], line["y2"]) + 1):
				map[i][line["x1"]] += 1
		elif line["y1"] == line["y2"]:
			for i in range(min(line["x1"], line["x2"]), max(line["x1"], line["x2"]) + 1):
				map[line["y1"]][i] += 1
	return countMapOver2(map)

func calculatePart2():
	var lines = getInput()
	var minMax = getMinMax(lines)
	var map = Utility.fill_array2d(minMax["maxX"], minMax["maxY"])
	for line in lines:
		if line["x1"] == line["x2"]:
			for i in range(min(line["y1"], line["y2"]), max(line["y1"], line["y2"]) + 1):
				map[i][line["x1"]] += 1
		elif line["y1"] == line["y2"]:
			for i in range(min(line["x1"], line["x2"]), max(line["x1"], line["x2"]) + 1):
				map[line["y1"]][i] += 1
		else:
			var xdiff = sign(line["x2"] - line["x1"])
			var ydiff = sign(line["y2"] - line["y1"])
			var x = line["x1"]
			var y = line["y1"]
			while(true):
				map[y][x] += 1
				if x == line["x2"] && y == line["y2"]: break
				x += xdiff
				y += ydiff
	return countMapOver2(map)

func getMinMax(lines):
	var minMax = {
		"minX": lines[0]["x1"],
		"maxX": lines[0]["x1"],
		"minY": lines[0]["y1"],
		"maxY": lines[0]["y1"]
	}
	for l in lines:
		if minMax["minX"] > l["x1"]: minMax["minX"] = l["x1"]
		if minMax["minX"] > l["x2"]: minMax["minX"] = l["x2"]
		if minMax["minY"] > l["y1"]: minMax["minY"] = l["y1"]
		if minMax["minY"] > l["y2"]: minMax["minY"] = l["y2"]
		if minMax["maxX"] < l["x1"]: minMax["maxX"] = l["x1"]
		if minMax["maxX"] < l["x2"]: minMax["maxX"] = l["x2"]
		if minMax["maxY"] < l["y1"]: minMax["maxY"] = l["y1"]
		if minMax["maxY"] < l["y2"]: minMax["maxY"] = l["y2"]
	return minMax

func countMapOver2(map):
	var result = 0
	for y in range(0, map.size()):
		for x in range(0, map[y].size()):
			if map[y][x] >= 2:
				result += 1
	return result
