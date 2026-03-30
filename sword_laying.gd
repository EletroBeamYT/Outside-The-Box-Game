extends RigidBody3D



func _on_area_3d_area_entered(area: Area3D) -> void:
	$".".visible = false
	$".".collision_layer = false
	gravity_scale = 1000000000 # use just this if you're evil >:D
