extends RigidBody3D


@onready var audio = $AudioStreamPlayer3D


var level = 1

var level_save = "user://level.save"


signal update_level

var attacking = 0

const MIN_IMPACT_VELOCITY = 1.0


func _ready():
	if FileAccess.file_exists(level_save):
		var file = FileAccess.open(level_save, FileAccess.READ)
		level = file.get_var(level)
		print(level)
	else:
		var file = FileAccess.open(level_save, FileAccess.WRITE)
		file.store_var(level)

	body_entered.connect(_on_area_entered)
	contact_monitor = true
	max_contacts_reported = 4


func _on_area_entered(area):
	var impact_speed = linear_velocity.length()
	if impact_speed < MIN_IMPACT_VELOCITY:
		return
	if audio.playing:
		return
	audio.volume_db = lerp(-20.0, 0.0, clamp(impact_speed / 10.0, 0.0, 1.0))
	audio.play()


func _on_area_3d_area_entered(area: Area3D) -> void:
	#audio.play()
	if attacking == 0:
		print("thats not how you open a box...")
	if attacking == 1:
		if level == 20:
			get_tree().change_scene_to_file("res://End.tscn")
		else:
			emit_signal("update_level")
			get_tree().change_scene_to_file("res://dead.tscn")
		if level > 20:
			get_tree().change_scene_to_file("res://End.tscn")

func _on_character_body_3d_attacking() -> void:
	await get_tree().create_timer(0.21).timeout
	attacking = 1
	await get_tree().create_timer(0.21).timeout
	attacking = 0
