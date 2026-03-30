extends Node3D


func _on_node_2d_started() -> void:
	$"../../Poster".mass = 1.0
	$"../../Poster".gravity_scale = 1.0
