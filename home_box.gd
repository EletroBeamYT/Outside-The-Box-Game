extends Node3D

var windowed = 0

func _input(event):
	if Input.is_action_pressed("F11"):
		if windowed == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			print("test 1")
			windowed = 0
			await get_tree().create_timer(9999999999).timeout
		if windowed == 0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			print("test 2")
			windowed = 1
			await get_tree().create_timer(9999999999).timeout
