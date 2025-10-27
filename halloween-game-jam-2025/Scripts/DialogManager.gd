extends Control

signal dialog_started
signal dialog_ended

@onready var name_label = $MarginContainer/DialogBox/NameLabel

func _ready() -> void:
	Dialogic.Text.speaker_updated.connect(change_name)
	Dialogic.signal_event.connect(on_dialogic_signal)
	
func start_dialog(timeline : String):
	visible = true
	Dialogic.start(timeline)
	dialog_started.emit()

func change_name(character) -> void:
	if character:
		name_label.text = character.display_name
	
func on_dialogic_signal(argument : String):
	match argument:
		"end":
			visible = false
			dialog_ended.emit()
