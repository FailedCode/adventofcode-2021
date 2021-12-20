extends AbstractDay

func getTitle() -> String:
	return "Day 20: Trench Map"

func getInput():
	var lines = getInputAsLinesRaw()
	var algo = {}
	var k = 0
	for c in lines[0]:
		algo[String(k)] = true if c == "#" else false
		k += 1

	var image = Utility.fill_array2d(lines[2].length(), lines.size() - 2, false)
	var y = 0
	for i in range(2, lines.size()):
		var x = 0
		for c in lines[i]:
			image[y][x] = true if c == "#" else false
			x += 1
		y += 1
	return {"image": image, "algo": algo}

func calculatePart1():
	var tmp = getInput()
	var image = tmp["image"]
	var algo = tmp["algo"]
	for _i in range(0, 2):
#		printImage(image)
#		print(" - - - ")
		image = enhanceImage(image, algo)
	printImage(image)
	return countEnabled(image)

func enhanceImage(image, algo):
	var border = 2
	var height = image.size()
	var width = image[0].size()
	var result = Utility.fill_array2d(width + border * 2, height + border * 2, false)
	for y in range(-border, height + border):
		for x in range(-border, width + border):
			var sum = sumNeighbours(image, x, y)
			result[y+border][x+border] = algo[String(sum)]
	return result

func sumNeighbours(image, x, y):
	var sum = 0
	var bits = 8
	var height = image.size()
	var width = image[0].size()
	for ya in [-1, 0, 1]:
		for xa in [-1, 0, 1]:
#			Utility.log("{0}, {1}", [x+xa, y+ya])
			if y + ya < 0 || x + xa < 0:
				bits -= 1
				continue
			if y + ya >= height || x + xa >= width:
				bits -= 1
				continue
			if image[y + ya][x + xa]:
#				Utility.log("pow(2, {0}) = {1} @ {2}, {3}", [bits, pow(2, bits), x+xa, y+ya])
				sum += pow(2, bits)
			bits -= 1
#	Utility.log("=> '{0}'", [sum])
	return sum

func countEnabled(image):
	var count = 0
	for row in image:
		for col in row:
			if col:
				count += 1
	return count

func printImage(image):
	for row in image:
		var line = ""
		for col in row:
			if col:
				line += "#"
			else:
				line += "."
		print(line)
