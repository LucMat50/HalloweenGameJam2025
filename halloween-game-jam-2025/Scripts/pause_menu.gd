extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	hide()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()

func testEsc():
	if Input.is_action_just_pressed("escape"):
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "blur" and !get_tree().paused:
		hide()

func _process(_delta: float) -> void:
	testEsc()
