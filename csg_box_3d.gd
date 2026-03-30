extends CSGBox3D


func _ready() -> void:
	$"../random".play("RESET")
	var random = randi_range(1, 100)
	print("random number is ", random)
	if random == 1.0:
		$"../random".play("random")
# this took forever for the dumbest thing ever
