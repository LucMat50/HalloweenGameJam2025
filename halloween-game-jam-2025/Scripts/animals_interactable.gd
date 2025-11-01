extends Sprite2D

var player_in_range:bool = false
var has_interacted : bool = false
var bucket_filled : bool = false
var puzzle2_done : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Able to Interact")
		player_in_range = true

func _body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false

func _process(_delta: float):
	if player_in_range and Input.is_action_just_pressed("interact") and !puzzle2_done:
		if !has_interacted:
			Dialogic.start("Animals")
			has_interacted = true
		elif bucket_filled:
			Dialogic.start("Animals2")
			puzzle2_done = true

func _on_hose_object_bucket_filled() -> void:
	bucket_filled = true
