extends Node2D


var puzzleInput
var part1ResultLabel
var part2ResultLabel

func _ready():
	part1ResultLabel = find_node("Part1Result")
	part2ResultLabel = find_node("Part2Result")
	puzzleInput = find_node("PuzzleInput")
	var part = find_node("Part1")
	part.connect("button_up", self, "_on_Part1_button_up")
	find_node("Part2").connect("button_up", self, "_on_Part2_button_up")
	var back = find_node("back")
	back.connect("button_up", self, "_on_back_button_up")

func _on_back_button_up():
	Utility.change_scene({"scene": "res://Scenes/MainScene.tscn"})
