extends Node3D


var can_close_door = 0

signal RESET

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dore_trigger_area_entered(area: Area3D) -> void:
	$DoorMove.play("door close")
	$AudioStreamPlayer3D.play()
	print("no")
	emit_signal("RESET")
