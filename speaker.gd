extends AudioStreamPlayer3D

var level = 1

var level_save = "user://level.save"

var voice_line_said = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if FileAccess.file_exists(level_save):
		var file = FileAccess.open(level_save, FileAccess.READ)
		level = file.get_var(level)
		print(level)
	else:
		var file = FileAccess.open(level_save, FileAccess.WRITE)
		file.store_var(level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("fnewuncfuwsncbeuwe")
	$".".play()
	
