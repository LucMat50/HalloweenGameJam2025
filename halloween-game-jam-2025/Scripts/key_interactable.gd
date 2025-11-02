extends Area2D

#VARIABLES
#@onready var slots = $Inv_UI/NinePatchRect/GridContainer.get_children()
var player_in_range:bool = false
var player_has_key:bool = false

#FUNCTIONS

func _ready():
	$Label.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Able to Interact")
		player_in_range = true
		if player_has_key:
			$Label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		$Label.hide()

func _on_key_key_1() -> void:
	player_has_key = true
	print("Player has key!")
	
#CHECKS IF PLAYER HAS COLLECTED KEY1
func _process(_delta: float):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if player_has_key:
			print("Open")
			AudioGlobal.playSoundEffect("door_open")
			#allows the player to teleport (get out) of the shed
			var target_node = $"../Shed/TeleportFromShed"
			var target_collsion = $"../Shed/TeleportFromShed/CollisionShape2D"
			if target_node:
				target_node.visible = true
			if target_collsion:
				target_collsion.disabled = false
			else:
				print("Target node not found:", $"../Shed/TeleportFromShed")
			queue_free()
