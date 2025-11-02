extends Area2D

@export var landing_zone : Area2D
@export var is_window : bool = false
@export var can_window : bool = false

func _on_body_entered(body: Node2D) -> void:
	#check if the body colliding is the player
	if (is_window and can_window) or !is_window:
		if not body.is_in_group("player"):
			return
		#check if the body colliding "can tp"
		if not body.can_tp:
			return
		body.can_tp = false
		#play fade animation
		AudioGlobal.playSoundEffect("door_open")
		$"../../Player/Camera2D/CanvasLayer/fade_transition".show()
		$"../../FadeTimer".start()
		$"../../Player/Camera2D/CanvasLayer/fade_transition"/AnimationPlayer.play("fade_in")
		#TP to marker
		var tp_point = landing_zone.get_node("Marker2D").global_position
		body.global_position = tp_point
		
		#cooldown to prevent tp spamming
		await get_tree().create_timer(1.0).timeout
		body.can_tp = true


func _on_animals_animals_done() -> void:
	if is_window:
		can_window = true


func _on_fade_timer_timeout() -> void:
	$"../../Player/Camera2D/CanvasLayer/fade_transition"/AnimationPlayer.play("fade_out")
	$"../../Player/Camera2D/CanvasLayer/fade_transition".hide()
