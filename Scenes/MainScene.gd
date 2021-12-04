extends Node2D

var days = []

func _ready():
	# center window
	var monitorId = 0
	var screen_size = OS.get_screen_size(monitorId)
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	
	var size = 64
	var row = 0
	var col = 0
	for day in range(1, 25):
		var button = Button.new()
		button.text = String(day)
		button.rect_size = Vector2(size, size)
		button.rect_position = Vector2(
			size + size * col + size * 0.5 * col,
			size + size * row + size * 0.5 * row)
		if day % 2 == 0:
			button.set_modulate(Color(1, 0, 0, 1))
		else:
			button.set_modulate(Color(0, 1, 0, 1))
		button.connect("button_up", self, "_on_day_button_pressed", [String(day)])
		add_child(button)
		col += 1
		if col == 9:
			col = 0
			row += 1

func _on_ButtonEnd_button_up():
	get_tree().quit()

func _on_day_button_pressed(day):
	print("switch to day " + day)
	var script = "res://Days/Day" + day + ".gd"
	if !File.new().file_exists(script):
		script = "res://Days/AbstractDay.gd"
	var scene = "res://Scenes/Day.tscn"
	Utility.change_scene({"script": script, "scene": scene})
