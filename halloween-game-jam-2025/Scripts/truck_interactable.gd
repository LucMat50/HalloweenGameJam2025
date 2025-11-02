extends Area2D

@export var item: InvItem
var player = null
var player_in_range = false
var has_engine : bool = false
var has_manual : bool = false
var has_key : bool = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	$Label.hide()

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Enter")
		player_in_range = true
		player = body
		$Label.show()

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		player = null
		$Label.hide()

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if item.puzzle.active == true and (has_engine and has_manual and !has_key):
			player.dialog_manager.start_dialog("MissingPlushie")
		elif item.puzzle.active == true and has_engine and has_manual and has_key:
			player.dialog_manager.start_dialog("TruckFixed")
		elif item.puzzle.active == true:
			player.dialog_manager.start_dialog(item.description_timeline)
			has_engine = true

func _on_engine_truck_engine() -> void:
	item.puzzle.active = true

func _on_safe_input_manual() -> void:
	has_manual = true

func _on_plushie_plushie() -> void:
	has_key = true
