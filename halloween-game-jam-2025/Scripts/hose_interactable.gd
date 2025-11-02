extends Area2D

@export var item: InvItem
var player = null
var player_in_range = false

signal bucket_filled

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

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
		if item.puzzle.active:
			if player and player.inv.hasItem(item.puzzle.requiredItems[0]):
				player.dialog_manager.start_dialog(item.description_timeline)
				AudioGlobal.playSoundEffect("hose")
				bucket_filled.emit()
		else:
			player.dialog_manager.start_dialog("PrereqNotMetBasic")

func _on_bucket_bucket() -> void:
	item.puzzle.active = true
