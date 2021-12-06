extends Node

#https://docs.godotengine.org/en/latest/tutorials/scripting/singletons_autoload.html
var current_scene
var config

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	config = loadConfig()
	
func loadConfig():
	var configFile = File.new()
	configFile.open("res://Config/config.json", File.READ)
	var parsed = JSON.parse(configFile.get_as_text())  
	return parsed.result

func change_scene(arguments):
	call_deferred("_deferred_change_scene", arguments)

# deferring is a MUST so you can remove the current scene
func _deferred_change_scene(arguments):
	current_scene.free()
	var scene = ResourceLoader.load(arguments["scene"])
	current_scene = scene.instance()
	if "script" in arguments:
		var script = ResourceLoader.load(arguments["script"])
		current_scene.set_script(script)
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	
func bin2int(binaryString) -> int:
	var result = 0
	binaryString = string_reverse(binaryString)
	for i in range(0, binaryString.length()):
		var c = binaryString[i]
		if c == "1":
			result += pow(2, i)
			
	return result

func string_reverse(string):
	var result = ""
	for i in range(string.length() - 1, -1, -1):
		result += string[i]
	return result

func fill_array(size, value = 0, array = null) -> Array:
	if array == null:
		array = []
	for i in size:
		array.append(value)
	return array

func array_sum(array) -> int:
	var sum = 0
	for i in array:
		sum += i
	return sum

func regex_find(expression, subject):
	var regex = RegEx.new()
	regex.compile(expression)
	return regex.search(subject)
