extends Area2D

#VARIABLES
#@onready var slots = $Inv_UI/NinePatchRect/GridContainer.get_children()
var player_in_range:bool = false
var player_has_saw:bool = false

#FUNCTIONS
func _ready():
	$Label.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Able to Interact")
		player_in_range = true
		$Label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		$Label.hide()

#CHECKS IF PLAYER HAS COLLECTED KEY1
func _process(_delta: float):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if player_has_saw:
			print("Open")
			
			#teleport the key to it's position
			if $"../../Key":
				var target_node = $"../../Key"
				if target_node:
					target_node.global_position = global_position
					print("Saw moved to target position:", global_position)
				else:
					print("Target node not found:", $"../../Key")
			
			queue_free()

func _on_saw_saw() -> void:
	player_has_saw = true
	print("Player has saw!")
