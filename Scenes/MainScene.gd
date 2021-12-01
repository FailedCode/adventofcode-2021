extends Node2D

func _ready():
	# center window
	var monitorId = 0
	var screen_size = OS.get_screen_size(monitorId)
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ButtonEnd_button_up():
	get_tree().quit()
