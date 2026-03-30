extends RigidBody3D

func _ready():
	# These are the key properties for realistic box behavior
	mass = 1.0                    # heavier = more force needed to move
	gravity_scale = 1.0           # 1.0 = normal gravity
	linear_damp = 0.1             # air resistance on movement
	angular_damp = 0.1            # air resistance on rotation
	
	# Optional: give it a random spin when it spawns
	angular_velocity = Vector3(randf(), randf(), randf()) * 3.0
