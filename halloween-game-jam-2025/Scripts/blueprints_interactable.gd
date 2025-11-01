extends Area2D

@export var item: InvItem
var player = null
var player_in_range = false
signal Blueprint

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	Dialogic.signal_event.connect(on_dialogic_signal)
	
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
			Blueprint.emit()
			var success = player.tryCollect(item)  # give item to player
			if success:
				queue_free()  # remove item from world

func on_dialogic_signal(argument:String):
	if argument == "canFindBlueprint":
		item.puzzle.active = true
