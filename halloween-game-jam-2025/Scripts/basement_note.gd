extends Area2D

@export var item: InvItem
var player = null
var player_in_range = false
signal basementNote

func _ready() -> void:
	$Sprite2D.hide()
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Enter")
		player_in_range = true
		player = body

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		player = null

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if player:
			basementNote.emit()
			var success = player.tryCollect(item)  # give item to player
			if success:
				queue_free()
