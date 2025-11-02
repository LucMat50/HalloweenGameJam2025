extends Node2D

func _ready():
	$Player/Camera2D/CanvasLayer/fade_transition/AnimationPlayer.play("fade_out")
	Dialogic.signal_event.connect(on_dialogic_signal)

func _on_world_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/bad_end_cutscene.tscn")

func on_dialogic_signal(argument:String):
	if argument == "endGame":
		get_tree().change_scene_to_file("res://Scenes/good_end_cutscene.tscn")
	
