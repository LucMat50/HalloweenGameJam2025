extends Area2D

@export var item: InvItem
var player = null
var player_in_range = false
var open = false
@onready var open_closet = $Open

signal start_combo

func _ready():
	open_closet.hide()
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
		AudioGlobal.playSoundEffect("door_open")
		open_closet.show()
		player.dialog_manager.start_dialog(item.description_timeline)
		start_combo.emit()

func _on_safe_input_manual() -> void:
	player.dialog_manager.start_dialog("Manual")
	
func _on_safe_input_wrong() -> void:
	player.dialog_manager.start_dialog("Wrong")
