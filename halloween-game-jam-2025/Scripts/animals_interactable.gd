extends Sprite2D

var player_in_range:bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Able to Interact")
		player_in_range = true

func _body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false

func _process(_delta: float):
	if player_in_range and Input.is_action_just_pressed("interact"):
		Dialogic.start("Animals")
