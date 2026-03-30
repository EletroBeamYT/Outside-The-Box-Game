extends Node3D


var level = 1


var level_save = "user://level.save"


func _ready() -> void:
	$DaHum.play()
	if FileAccess.file_exists(level_save):
		var file = FileAccess.open(level_save, FileAccess.READ)
		level = file.get_var(level)
		print(level)
		if level == 6:
			$"Test 6 mudders".play()
		if level == 7:
			$"Test 7".play()
			
	else:
		var file = FileAccess.open(level_save, FileAccess.WRITE)
		file.store_var(level)




func _on_dore_trigger_area_entered(area: Area3D) -> void:
	if level == 1:
		await get_tree().create_timer(0.5).timeout
		$"Test 1".play()
	if level == 2:
		await get_tree().create_timer(0.5).timeout
		$"Test 2".play()
	if level == 3:
		await get_tree().create_timer(0.5).timeout
		$"Test 3".play()
	if level == 4:
		await get_tree().create_timer(0.5).timeout
		$"Test 4".play()
	if level == 5:
		await get_tree().create_timer(0.5).timeout
		$"Test 5".play()
	if level == 6:
		#await get_tree().create_timer(0.5).timeout
		$"Test 6 mudders".stop()
		$"Test 6".play()
	if level == 8:
		var random = randi_range(1, 100)
		print("random number is ", random)
		if random == 1.0:
			print("egg")
			$"Test 8 egg".play()
			await get_tree().create_timer(10.87).timeout
			$"Test 8".play()
		else:
			$"Test 8".play()
	if level == 9:
		await get_tree().create_timer(0.5).timeout
		$"Test 9".play()
	if level == 10:
		await get_tree().create_timer(0.5).timeout
		$"Test 10".play()
	if level == 11:
		$"Test 11".play()
	if level == 12:
		await get_tree().create_timer(0.5).timeout
		$"Test 12".play()
	if level == 13:
		await get_tree().create_timer(0.5).timeout
		$"Test 13".play()
	if level == 14:
		await get_tree().create_timer(0.3).timeout
		$"Test 14".play()
	if level == 15:
		await get_tree().create_timer(0.5).timeout
		$"Test 15".play()
	if level == 16:
		await get_tree().create_timer(0.5).timeout
		$"Test 16".play()
	if level == 17:
		await get_tree().create_timer(0.2).timeout
		$"Test 17".play()
	if level == 18:
		await get_tree().create_timer(0.5).timeout
		$"Test 18".play()
	if level == 19:
		await get_tree().create_timer(0.5).timeout
		$"Test 19".play()
	if level >= 20:
		await get_tree().create_timer(0.5).timeout
		$"Test 20".play()
		await get_tree().create_timer(18000).timeout
		$TRUEENDING.play()
		get_tree().change_scene_to_file("res://End.tscn")
