extends RigidBody3D

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
	if level < 2:
		$".".visible = false
		$chair.visible = false
		$CollisionShape3D.disabled = true
		$CollisionShape3D2.disabled = true
		$AudioStreamPlayer3D.visible = false
		$AudioStreamPlayer3D.volume_db = -100

	contact_monitor = true
	max_contacts_reported = 4
	body_entered.connect(_on_body_entered)

# colision sounds
@onready var audio = $AudioStreamPlayer3D
const MIN_IMPACT_VELOCITY = 1.5 


func _on_body_entered(body: Node):
	if level > 1:
		var impact_speed = linear_velocity.length()
		if impact_speed < MIN_IMPACT_VELOCITY:
			return
		if audio.playing:
			return
		audio.volume_db = lerp(-20.0, 0.0, clamp(impact_speed / 10.0, 0.0, 1.0))
		audio.play()
	else:
		print("NOOOOO")
