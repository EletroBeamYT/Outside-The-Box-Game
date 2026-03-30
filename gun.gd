extends RigidBody3D

signal gun


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
	if level < 20:
		$".".visible = false
		$Sketchfab_Scene.visible = false
		$Area3D.visible = false
		$CollisionShape3D.disabled = true
	contact_monitor = true
	max_contacts_reported = 4



func _on_area_3d_area_entered(area: Area3D) -> void:
	$".".visible = false
	$CollisionShape3D.disabled = true
	emit_signal("gun")
	gravity_scale = 1000000000 # use just this if you're evil >:D
	$".".position.y = 1000
