extends Node

#https://docs.godotengine.org/en/latest/tutorials/scripting/singletons_autoload.html
var current_scene

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

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
	