extends Node2D



func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(48).timeout
	get_tree().change_scene_to_file("res://home_box.tscn")
