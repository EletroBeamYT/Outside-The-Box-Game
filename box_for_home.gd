extends RigidBody3D

# colision sounds
@onready var audio = $AudioStreamPlayer3D
const MIN_IMPACT_VELOCITY = 1.5 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4
	body_entered.connect(_on_body_entered)



func _on_body_entered(body: Node):
	var impact_speed = linear_velocity.length()
	if impact_speed < MIN_IMPACT_VELOCITY:
		return
	#audio.volume_db = lerp(-20.0, 0.0, clamp(impact_speed / 10.0, 0.0, 1.0))
	audio.play()
