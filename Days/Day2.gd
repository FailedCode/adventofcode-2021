extends AbstractDay


func calculatePart1() -> String:
	var commands = getInputAsCommands()
	var x = 0
	var y = 0
	
	for command in commands:
		match command["dir"]:
			"up":
				y -= command["val"]
			"down":
				y += command["val"]
			"forward":
				x += command["val"]
	
	return x * y

func calculatePart2() -> String:
	var commands = getInputAsCommands()
	var x = 0
	var y = 0
	var aim = 0
	
	for command in commands:
		match command["dir"]:
			"up":
				aim -= command["val"]
			"down":
				aim += command["val"]
			"forward":
				x += command["val"]
				y += command["val"] * aim

	return x * y

func getInputAsCommands() -> Array:
	var commands = [];
	var lines = getInputAsLines()

	var regex = RegEx.new()
	regex.compile("(\\w+)\\s(\\d+)")

	for line in lines:
		var result = regex.search(line)
		commands.append({
			"dir": result.get_string(1),
			"val": int(result.get_string(2))
		})

	return commands
