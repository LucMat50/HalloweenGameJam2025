extends Control


func _ready() -> void:
	AudioGlobal.changeMusic("horror_ambience")
	$Butcher.visible = false
	Dialogic.signal_event.connect(_on_dialogic_signal)
	
func _on_dialogic_signal(argument : String):
	if argument == "butcher":
		AudioGlobal.pauseMusic()
		$Butcher.visible = true
	elif argument == "end":
		get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")

func _on_delay_timeout() -> void:
	Dialogic.start("GoodEnding")
		
