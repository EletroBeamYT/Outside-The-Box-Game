extends CharacterBody3D

@onready var slime: Node3D = $CollisionShape3D/MeshInstance3D/slime


const SPEED = 2.0
const JUMP_VELOCITY = 4.5
const DETECTION_DISTANCE = 6.0  

var move_direction: Vector3
var change_time := 2.0
var timer := 0.0

var rng = RandomNumberGenerator.new()
var player: CharacterBody3D

var knockbackvelocity: Vector3


func _ready():
	rng.randomize()
	pick_new_direction()
	player = $"../CSGCombiner3D/CharacterBody3D" 
	add_to_group("slime")

func pick_new_direction():
	var x = rng.randf_range(-1.0, 1.0)
	var z = rng.randf_range(-1.0, 1.0)
	move_direction = Vector3(x, 0, z).normalized()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player < DETECTION_DISTANCE:
		move_to_player()
	else:
		random_movement(delta)

	move_and_slide()

	if knockbackvelocity:
		velocity = knockbackvelocity



func move_to_player():
	var direction = (player.global_position - global_position).normalized()
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

func random_movement(delta):
	timer += delta
	if timer >= change_time:
		timer = 0
		pick_new_direction()

	velocity.x = move_direction.x * SPEED
	velocity.z = move_direction.z * SPEED



func get_knockback(knockbackdirection, knockbackforce):
	knockbackvelocity = knockbackdirection * knockbackforce
	
	await get_tree().create_timer(0.1).timeout
	
	knockbackvelocity = Vector3.ZERO


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == self: return
	
	if body.has_method("slime"):
		var knockbackdirection = global_position.direction_to(body.global_position)
		knockbackdirection.y = 0
		body.get_knockback(knockbackdirection, 20)
