extends Node3D

# enemy

var helth = 25

var player_hitting = false
var player_not_hitting = true

@export var speed := 2.5
@export var chase_speed := 2.5
@export var stop_chase_distance := 12.0
@export var move_time_min := 3.0
@export var move_time_max := 5.0
@export var jump_velocity = 4.5

@onready var move_timer: Timer = $MoveTimer
@onready var player: CharacterBody3D = $"../CharacterBody3D"


var chasing := false
var move_direction: Vector3 = Vector3.ZERO
var rng := RandomNumberGenerator.new()

var hit = false
var no_hit = true

func _ready():
	rng.randomize()
	pick_new_direction()



func wander():
	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed

func chase_player():
	var direction = (player.global_position - global_position)
	direction.y = 0
	direction = direction.normalized()

	velocity.x = direction.x * chase_speed
	velocity.z = direction.z * chase_speed

	# Stop chasing if player is far enough
	if global_position.distance_to(player.global_position) > stop_chase_distance:
		player_not_nearby()

func pick_new_direction():
	move_direction = Vector3(
		rng.randf_range(-1, 1),
		0,
		rng.randf_range(-1, 1)
	).normalized()

	move_timer.wait_time = rng.randf_range(move_time_min, move_time_max)
	move_timer.start()

func _on_move_timer_timeout() -> void:
	if not chasing:
		pick_new_direction()

func player_nearby() -> void:
	chasing = true
	move_timer.stop()

func player_not_nearby() -> void:
	chasing = false
	pick_new_direction()


func _on_area_3d_player_hitting() -> void:
	player_hitting = true
	player_not_hitting = false


func _on_area_3d_player_not_hitting() -> void:
	player_not_hitting = true
	player_hitting = false
