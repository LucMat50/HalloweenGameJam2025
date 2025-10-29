extends Control
class_name DialogManager

signal dialog_started
signal dialog_ended

@onready var name_label = $MarginContainer/DialogBox/NameLabel
@onready var item_image = $MarginContainer2/ItemImage

func _ready() -> void:
	visible = false
	Dialogic.Text.speaker_updated.connect(change_name)
	Dialogic.signal_event.connect(on_dialogic_signal)
	
func start_dialog(timeline : String):
	visible = true
	Dialogic.start(timeline)
	dialog_started.emit()
	
func show_image(image : CompressedTexture2D):
	if image:
		visible = true
		item_image.texture = image
	else:
		visible = false

func change_name(character) -> void:
	if character:
		name_label.text = character.display_name
	
func on_dialogic_signal(argument : String):
	match argument:
		"end":
			visible = false
			dialog_ended.emit()
