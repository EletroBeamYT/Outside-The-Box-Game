extends Area3D

signal Player_Hurt
signal Player_Not_Hurt

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	emit_signal("Player_Hurt")
	print("Area entered:", area.name)


func _on_area_exited(area):
	emit_signal("Player_Not_Hurt")
	print("Area left:", area.name)
