extends Node2D

var part1ResultLabel
var puzzleInput

func _ready():
	part1ResultLabel = find_node("Part1Result")
	puzzleInput = find_node("PuzzleInput")

func _on_Part1_button_up():
	var result = calculatePart1()
	part1ResultLabel.text = result

func calculatePart1():
	var inputText = puzzleInput.text
	var numbers = inputText.split("\n", false);
	var prev = 0
	var increases = 0
	for i in range(1, numbers.size()):
		if int(numbers[i]) > int(numbers[prev]):
			increases += 1
		prev = i
		
	return String(increases)
