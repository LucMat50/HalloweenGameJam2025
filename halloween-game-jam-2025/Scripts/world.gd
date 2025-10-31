extends Node2D

func _ready():
	$Player/Camera2D/CanvasLayer/fade_transition/AnimationPlayer.play("fade_out")

func _on_world_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/bad_end_cutscene.tscn")
