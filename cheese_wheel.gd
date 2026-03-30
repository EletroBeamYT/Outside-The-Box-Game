extends RigidBody3D

var cheese_mass = 8

var cheese_scale = 0.325

var cheese_check = 1

var level = 1

var level_save = "user://level.save"

# colision sounds
@onready var audio = $AudioStreamPlayer3D
const MIN_IMPACT_VELOCITY = 1.5 


func _ready() -> void:
	if FileAccess.file_exists(level_save):
		var file = FileAccess.open(level_save, FileAccess.READ)
		level = file.get_var(level)
		print(level)
	else:
		var file = FileAccess.open(level_save, FileAccess.WRITE)
		file.store_var(level)
	if level < 9:
		$".".visible = false
		$".".collision_layer = false
		$AudioStreamPlayer3D.volume_db = -100
	contact_monitor = true
	max_contacts_reported = 4
	body_entered.connect(_on_body_entered)

	if level > 9:
		if level > 12:
			print("CHEESE CONTAINED")
		else:
		# this is another exsample when ai isnt nessasary to make dumb stuff, gosh i dont feeel well
			print(cheese_check, " cheese check")
			cheese_check = level
			print(cheese_check, " cheese check")
			cheese_check -= 9
			cheese_mass *= cheese_check
			print(cheese_check, " cheese check")
			cheese_check /= 1.5
			print(cheese_check, " cheese check")
			
			#$CollisionShape3D.scale = Vector3(0.51 + cheese_check, 0.133 + cheese_check, 0.51 + cheese_check)
			#$CollisionShape3D2.scale = Vector3(0.525 + cheese_check, 0.525 + cheese_check, 0.525 + cheese_check)
			$"Cheese Wheel".scale = Vector3(cheese_check, cheese_check, cheese_check)
			$CollisionShape3D3.scale = Vector3(1 + cheese_check, 1 + cheese_check, 1 + cheese_check)
			$".".mass = cheese_mass
			#cheese_check += cheese_scale
			print(level, " level")
			print(cheese_check, " cheese check")
			print(cheese_scale, " cheese")
			#$"Cheese Wheel".scale = Vector3(cheese_check, cheese_check, cheese_check)




func _on_body_entered(body: Node):
	if level > 8:
		var impact_speed = linear_velocity.length()
		if impact_speed < MIN_IMPACT_VELOCITY:
			return
		if audio.playing:
			return
		audio.volume_db = lerp(-20.0, 0.0, clamp(impact_speed / 10.0, 0.0, 1.0))
		audio.play()
	else:
		print("NOOOOO")
