extends Node2D

var fading_in = false

@onready var label_animation = $Label/AnimationPlayer
@onready var colorRect_animation = $ColorRect/AnimationPlayer
@onready var hand_animation = $Hand/AnimationPlayer
@onready var colorRect2_animation = $ColorRect2/AnimationPlayer
@onready var label2_animation = $Label2/AnimationPlayer

func _ready() -> void:
	AudioGlobal.changeMusic("horror_ambience")
	label_animation.animation_finished.connect(_on_label_animation_finished)
	colorRect_animation.animation_finished.connect(_on_colorRect_animation_finished)
	hand_animation.animation_finished.connect(_on_hand_animation_finished)
	colorRect2_animation.animation_finished.connect(_on_colorRect2_animation_finished)
	label2_animation.animation_finished.connect(_on_label2_animation_finished)
	$Label.show()
	colorRect_animation.play("RESET_black")
	$ColorRect2.hide()
	$Label2.hide()
	$Control/GameOver.hide()
	$Label/AnimationPlayer.play("fade_in")


func _on_label_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		label_animation.play("fade_out")
	elif anim_name == "fade_out":
		$Label.hide()
		colorRect_animation.play("fade_out")
		
func _on_colorRect_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		hand_animation.play("Grab")

func _on_hand_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Grab":
		$ColorRect2.show()
		colorRect2_animation.play("fade_in")

func _on_colorRect2_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$Control/Butcher.hide()
		$Hand.hide()
		$Label2.show()
		$Control/GameOver.show()
		label2_animation.play("fade_in")
		AudioGlobal.playSoundEffect("meow")

func _on_label2_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		label2_animation.play("fade_out")
	elif anim_name == "fade_out":
		$Label2.hide()
		colorRect2_animation.play("fade_out")	

func _on_game_over_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			AudioGlobal.pauseMusic()
			get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
