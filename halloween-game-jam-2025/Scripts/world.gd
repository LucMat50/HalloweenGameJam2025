extends Node2D


func _on_world_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/bad_end_cutscene.tscn")
