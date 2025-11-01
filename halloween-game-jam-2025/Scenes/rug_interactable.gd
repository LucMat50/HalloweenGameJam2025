extends Area2D

#VARIABLES
#@onready var slots = $Inv_UI/NinePatchRect/GridContainer.get_children()
var player_in_range:bool = false
var player_has_blueprint:bool = false

#FUNCTIONS
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Able to Interact")
		player_in_range = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false

#CHECKS IF PLAYER HAS COLLECTED THE BLUEPRINT
func _process(_delta: float):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if player_has_blueprint:
			print("Open")
			
			#teleport the rolled rug to it's position
			if $"../RugRolled":
				var target_node = $"../RugRolled"
				var portal = $"../TeleportToBasement"
				if target_node:
					target_node.position = Vector2(-192,270)
					print("Rug moved to target position:", position)
				if portal:
					portal.position = Vector2(-300, 348)
				else:
					print("Target node not found:", $"../RugRolled")
			
			queue_free()



func _on_blueprints_blueprint() -> void:
	player_has_blueprint = true
	print("Player has blueprint!")
