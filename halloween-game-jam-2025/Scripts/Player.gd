class_name Player
extends CharacterBody2D

@export var speed : int = 70
@export var animation_tree : AnimationTree

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var input : Vector2
var playback : AnimationNodeStateMachinePlayback

func _ready() -> void:
	playback = animation_tree["parameters/playback"]
	sprite.play("down_idle")

func _physics_process(_delta: float) -> void:
	input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed
	
	move_and_slide()
	select_animation()
	update_animation_parameters()
	
func select_animation() -> void:
	if velocity == Vector2.ZERO:
		playback.travel("Idle")
	else:
		playback.travel("Walk")

func update_animation_parameters() -> void:
	if input == Vector2.ZERO:
		return
	animation_tree["parameters/Idle/blend_position"] = input
	animation_tree["parameters/Walk/blend_position"] = input
