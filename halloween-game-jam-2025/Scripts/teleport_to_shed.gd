extends Area2D

@export var landing_zone : Area2D

func _on_body_entered(body: Node2D) -> void:
	#check if the body colliding is the player
	if not body.is_in_group("player"):
		return
	#check if the body colliding "can tp"
	if not body.can_tp:
		return
	body.can_tp = false
	#TP to marker
	var tp_point = landing_zone.get_node("Marker2D").global_position
	body.global_position = tp_point
	
	#cooldown to prevent tp spamming
	await get_tree().create_timer(1.0).timeout
	body.can_tp = true
