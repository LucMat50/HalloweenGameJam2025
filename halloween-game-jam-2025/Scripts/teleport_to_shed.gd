extends Area2D

@export var landing_zone : Area2D

"""func _on_body_entered(body: Node2D) -> void:
	if not body.can_tp == true : return
	body.can_tp = false
	var tp_point = landing_zone.get_node("Marker2D").global_position
	body.global_position = tp_point
	await get_tree().create_timer(1.00).timeout
	body.can_tp = true"""

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	if not body.can_tp:
		return

	body.can_tp = false
	var tp_point = landing_zone.get_node("Marker2D").global_position
	body.global_position = tp_point

	await get_tree().create_timer(1.0).timeout
	body.can_tp = true
