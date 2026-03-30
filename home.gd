extends Node2D

signal started

var level = 1

var level_save = "user://level.save"

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if FileAccess.file_exists(level_save):
		var file = FileAccess.open(level_save, FileAccess.READ)
		level = file.get_var(level)
		print(level)
	else:
		var file = FileAccess.open(level_save, FileAccess.WRITE)
		file.store_var(level)






func _on_start_pressed() -> void:
	emit_signal("started")
	await get_tree().create_timer(1.7).timeout
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	var file = FileAccess.open(level_save, FileAccess.WRITE)
	level = 1
	file.store_var(level)
	print(level)


func _on_button_2_pressed() -> void:
	var file = FileAccess.open(level_save, FileAccess.WRITE)
	level = 19
	file.store_var(level)
	print(level)
