extends Node2D

var windowed = 0

var level = 1

var level_save = "user://level.save"



func _physics_process(delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://home_box.tscn")


func _ready() -> void:
	var random = randi_range(1, 4)
	print("random number for deads is ", random)
	if random == 1.0:
		$"1".visible = true
	if random == 2.0:
		$"2".visible = true
	if random == 3.0:
		$"3".visible = true
	if random == 4.0:
		$"4".visible = true

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://home_box.tscn")






	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if FileAccess.file_exists(level_save):
		var file = FileAccess.open(level_save, FileAccess.READ)
		level = file.get_var(level)
		print(level)
	else:
		var file = FileAccess.open(level_save, FileAccess.WRITE)
		file.store_var(level)


	#await get_tree().create_timer(3).timeout
	#get_tree().quit()



func _on_quit_lame_pressed() -> void:
	get_tree().change_scene_to_file("res://home_box.tscn")
	#get_tree().quit()


func _on_do_again_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")


func _input(event):
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
