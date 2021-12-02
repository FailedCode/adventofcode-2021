extends "res://Days/AbstractDay.gd"

func _on_Part1_button_up():
	var result = calculatePart1()
	part1ResultLabel.text = result

func calculatePart1():
	var inputText = puzzleInput.text
	var numbers = inputText.split("\n", false);
	var increases = diffNumbers(numbers)	
	return String(increases)

func diffNumbers(_numbers):
	var prev = 0
	var increases = 0
	for i in range(1, _numbers.size()):
		if int(_numbers[i]) > int(_numbers[prev]):
			increases += 1
		prev = i
	return increases

func _on_Part2_button_up():
	var result = calculatePart2()
	part2ResultLabel.text = result

func calculatePart2():
	var inputText = puzzleInput.text
	var numbers = inputText.split("\n", false);
	var prevA = 0
	var prevB = 1
	var sums = []
	for i in range(2, numbers.size()):
		sums.append(int(numbers[prevA]) + int(numbers[prevB]) + int(numbers[i]))
		prevA += 1
		prevB += 1
	var increases = diffNumbers(sums)
	return String(increases)

