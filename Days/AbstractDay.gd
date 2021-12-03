extends Node2D
class_name AbstractDay

var puzzleInput
var part1ResultLabel
var part2ResultLabel

func _ready() -> void:
	part1ResultLabel = find_node("Part1Result")
	part2ResultLabel = find_node("Part2Result")
	puzzleInput = find_node("PuzzleInput")
	var part = find_node("Part1")
	part.connect("button_up", self, "_on_Part1_button_up")
	find_node("Part2").connect("button_up", self, "_on_Part2_button_up")
	var back = find_node("back")
	back.connect("button_up", self, "_on_back_button_up")

func _on_Part1_button_up() -> void:
	part1ResultLabel.text = String(calculatePart1())

func _on_Part2_button_up() -> void:
	part2ResultLabel.text = String(calculatePart2())
	
func _on_back_button_up() -> void:
	Utility.change_scene({"scene": "res://Scenes/MainScene.tscn"})

func calculatePart1() -> String:
	return "not implemented yet"

func calculatePart2() -> String:
	return "not implemented yet"
