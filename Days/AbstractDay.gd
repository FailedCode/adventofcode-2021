extends Node2D
class_name AbstractDay

var dayNumber = 0
var puzzleInput
var part1ResultLabel
var part2ResultLabel

func _ready() -> void:
	var scriptPath = get_script().get_path()
	var regexResult = Utility.regex_find("Day(\\d+)\\.gd", scriptPath)
	dayNumber = int(regexResult.get_string(1))
	find_node("Title").text = getTitle()
	part1ResultLabel = find_node("Part1Result")
	part2ResultLabel = find_node("Part2Result")
	puzzleInput = find_node("PuzzleInput")
	puzzleInput.text = fetchInput()
	var part = find_node("Part1")
	part.connect("button_up", self, "_on_Part1_button_up")
	find_node("Part2").connect("button_up", self, "_on_Part2_button_up")
	var back = find_node("back")
	back.connect("button_up", self, "_on_back_button_up")
	
func getTitle() -> String:
	return "not implemented yet"

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

func getInputAsLines() -> Array:
	return puzzleInput.text.split("\n", false)

func getInputAsLinesRaw() -> Array:
	return puzzleInput.text.split("\n")
	
func fetchInput():
	var inputFile = File.new()
	var path = "res://Input/day" + String(dayNumber) + ".txt"
	var input = ""
	if !inputFile.file_exists(path):
		input = downloadInput(path)
		return ""
	inputFile.open(path, File.READ)
	input = inputFile.get_as_text()
	inputFile.close()
	return input

func downloadInput(filePath):
	if Utility.config == null:
		return
	var url = Utility.config["url"].replace("$DAY$", String(dayNumber))
	var headers = [
		"cookie: session=" + Utility.config["session"]
	]
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_downloadInput_complete", [filePath])	
	http_request.request(url, headers)

func _downloadInput_complete(result, status_code, headers, body, filePath):
	if status_code == 200:
		var text = body.get_string_from_utf8().strip_edges()
		var inputFile = File.new()
		inputFile.open(filePath, File.WRITE)
		inputFile.store_string(text)
		inputFile.close()
		puzzleInput.text = text
	


