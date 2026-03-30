extends CharacterBody3D

# player

var reset = 0

var radio = 0
var radio_playing = 0

var no_sword = 1

var no_gun = 1

var sword = 1

var gun = 0

var knockbackvelocity: Vector3
var knockbackvelocitysword: Vector3

var knockback = Vector3.ZERO

var knockbackidk = false

signal attacking

@onready var anim = $Camera3D/sord/AnimationPlayer

@export var speed = 5
@export var jump_velocity = 8
@export var look_sensitivity = 0.005

var player_helth = 100

var being_hit = false

var can_hit = false
var cant_hit = true

var player_x = 0
var player_z = 0


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera:Camera3D = $Camera3D

#knockback

var isattacking = false

func _ready(): 
	$AnimationPlayer.play("put away")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("player")

func _physics_process(delta):
	attack()
	var Movement_input = Input.get_vector("a","d","w","s").normalized() * speed
	if Input.is_action_pressed("run"):
		speed = 8.5
	else:
		speed = 5
	if not is_on_floor():
		velocity += get_gravity() * delta

 
	velocity = Movement_input.x * global_basis.x + Movement_input.y * global_basis.z + Vector3(0, velocity.y, 0)
 
	if is_on_floor():
		if Input.is_action_just_pressed("jump"): velocity.y = jump_velocity
	else: velocity.y -= gravity * delta


	if knockbackvelocity:
		velocity = knockbackvelocity

	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#var player = get_tree().get_first_node_in_group("Player")
	#var direction = global_position.direction_to(player.global_position)
	#direction.y = 0
	
	#velocity = direction * speed
	
	#look_at(player.global_position, Vector3.UP, true)


	#velocity = velocity.move_toward(Vector3.ZERO, 200 * delta)


	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody3D:
			var push_force = 1.0
			var direction = -collision.get_normal()
			collider.apply_central_impulse(direction * push_force)
		if collider == $"../../objects/BacketBall":
			var push_force = 3.0
			var direction = -collision.get_normal()
			collider.apply_central_impulse(direction * push_force)






func attack():
	if Input.is_action_pressed("attack") and not isattacking:
		if no_sword == 0:
			if gun == 1:
				isattacking = true
				$AudioStreamPlayer3D.play()
				await get_tree().create_timer(0.2).timeout
				isattacking = false
			elif gun == 0:
				isattacking = true
				emit_signal("attacking")
				if $AnimationPlayer.is_playing():
					await $AnimationPlayer.animation_finished
					$AnimationPlayer.play("RESET")
					emit_signal("attacking")
					isattacking = false
				else:
					$AnimationPlayer.play("swing")
					await get_tree().create_timer(0.791).timeout
					$AnimationPlayer.play("RESET")
					emit_signal("attacking")
					isattacking = false
		if no_sword == 1:
			pass







func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(event.relative.x * -look_sensitivity)
		camera.rotate_x(event.relative.y * -look_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

	if Input.is_action_pressed("1") and not isattacking:
		if no_sword == 0:
			if sword == 1:
				pass
			if sword == 0:
				$AnimationPlayer.play("bring up")
				$AnimationPlayerGun.play("gun_down")
				gun = 0
		if no_sword == 1:
			pass

	if Input.is_action_pressed("2") and not isattacking:
		if no_gun == 0:
			if gun == 1:
				pass
			if gun == 0:
				$AnimationPlayer.play("put away")
				$AnimationPlayerGun.play("gun_bring_up")
				gun = 1
				sword = 0
		if no_gun == 1:
			pass


# radio funcions
	if Input.is_action_pressed("e"):
		if radio == 1:
			if radio_playing == 1:
				radio_playing = 0
				$"../../objects/Radio/hi jonny".stop()
				print("not radio")
				await get_tree().create_timer(100000000).timeout
			if radio_playing == 0:
				radio_playing = 1
				$"../../objects/Radio/hi jonny".play()
				print("radio")
				await get_tree().create_timer(1000000).timeout
		if radio == 0:
			pass
	if Input.is_action_pressed("r"):
		if reset == 1:
			$".".position.x = -5
			$".".position.y = 2.862
			$".".position.z = 0
			#$".".rotation.y = -28.23
		if reset == 0:
			pass






func _process(delta: float) -> void:
	#print($".".global_position.x)
	player_x = global_position.x
	#print($".".global_position.z)
	player_z = global_position.z




func _on_hit_player_not_hit() -> void:
	being_hit = false


func _on_hit_player_touched() -> void:
	being_hit = true
	hitting_stuff()

func hitting_stuff():
	if being_hit == true:
		player_helth -= 5
		await get_tree().create_timer(0.5).timeout
		repeat()
		print(player_helth, "YOU ARE DYING")
	if being_hit == false:
		print("oh good, dont die, not like i care")
		print(player_helth, "YOU ARE NOT DYING")

func repeat():
	hitting_stuff()


func _on_area_3d_player_hitting_player() -> void:
	can_hit = true
	cant_hit = true


func _on_area_3d_player_not_hitting_player() -> void:
	can_hit = false
	cant_hit = true


func _on_hurt_box_player_hurt() -> void:
	knockbackidk = true

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


func _on_area_3d_area_entered(area: Area3D) -> void:
	no_sword = 0
	sword = 1
	gun = 0
	$AnimationPlayer.play("bring up")
	$AnimationPlayerGun.play("RESET")

# radio
func _on_area_3d_area_entered_radio(area: Area3D) -> void:
	radio = 1


func _on_area_3d_area_exited(area: Area3D) -> void:
	radio = 0


func _on_door_reset() -> void:
	reset = 1


func _on_gun_gun() -> void:
	no_gun = 0
	sword = 0
	gun = 1
	$AnimationPlayerGun.play("gun_bring_up")
	$AnimationPlayer.play("down")
