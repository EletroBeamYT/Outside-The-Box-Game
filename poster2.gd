extends RigidBody3D

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4
	body_entered.connect(_on_body_entered)

# colision sounds
@onready var audio = $AudioStreamPlayer3D
const MIN_IMPACT_VELOCITY = 1.5 


func _on_body_entered(body: Node):
	var impact_speed = linear_velocity.length()
	if impact_speed < MIN_IMPACT_VELOCITY:
		return
	audio.volume_db = lerp(-20.0, 0.0, clamp(impact_speed / 10.0, 0.0, 1.0))
	audio.play()
