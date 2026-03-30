extends Node3D

var windowed = 0

var level = 1

var level_save = "user://level.save"

func _ready() -> void:
	if FileAccess.file_exists(level_save):
		var file = FileAccess.open(level_save, FileAccess.READ)
		level = file.get_var(level)
		print(level)
	else:
		var file = FileAccess.open(level_save, FileAccess.WRITE)
		file.store_var(level)



func _on_the_box_update_level() -> void:
	level += 1
	print(level)
	if FileAccess.file_exists(level_save):
		var file = FileAccess.open(level_save, FileAccess.WRITE)
		file.store_var(level)
		print(level)

func _input(event):
	if Input.is_action_pressed("escape"):
		get_tree().change_scene_to_file("res://home_box.tscn")
	if Input.is_action_pressed("F11"):
		if windowed == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			print("test 1")
			windowed = 0
			await get_tree().create_timer(999999999).timeout
		if windowed == 0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			print("test 2")
			windowed = 1
			await get_tree().create_timer(9999999999).timeout
