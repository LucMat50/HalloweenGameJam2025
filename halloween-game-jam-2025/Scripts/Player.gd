class_name Player
extends CharacterBody2D

@export var walk_speed : int = 50
@export var sprint_speed : int = 90
@export var animation_tree : AnimationTree

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var camera : Camera2D = $Camera2D
@onready var dialog_manager : Control = $Camera2D/DialogCanvasLayer/DialogManager

enum State {IDLE, WALK, SPRINT, DIALOG}

var current_state = State.IDLE
var input : Vector2
var speed = walk_speed
var playback : AnimationNodeStateMachinePlayback

func _ready() -> void:
	playback = animation_tree["parameters/playback"]
	sprite.play("down_idle")

func _physics_process(_delta: float) -> void:
	if current_state != State.DIALOG:
		if Input.is_action_pressed("sprint"):
			change_state(State.SPRINT)
			speed = sprint_speed
		else:
			change_state(State.WALK)
			camera.end_screen_shake()
			speed = walk_speed
		
		input = Input.get_vector("left", "right", "up", "down")
		velocity = input * speed
		
		move_and_slide()
		select_animation()
		update_animation_parameters()
	
func change_state(new_state) -> void:
	if current_state == new_state:
		return
	current_state = new_state
	if current_state == State.SPRINT:
		camera.start_screen_shake(1.0, 1.0)
	
func select_animation() -> void:
	if velocity == Vector2.ZERO:
		change_state(State.IDLE)
		playback.travel("Idle")
	else:
		playback.travel("Walk")

func update_animation_parameters() -> void:
	if input == Vector2.ZERO:
		return
	animation_tree["parameters/Idle/blend_position"] = input
	animation_tree["parameters/Walk/blend_position"] = input
	
func player_enter_dialog() -> void:
	current_state = State.DIALOG
 
func player_exit_dialog() -> void:
	current_state = State.IDLE
