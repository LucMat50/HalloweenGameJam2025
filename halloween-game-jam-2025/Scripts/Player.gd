class_name Player
extends CharacterBody2D

#teleport code
var can_tp = true

@export var walk_speed : int = 70
@export var sprint_speed : int = 110
@export var animation_tree : AnimationTree

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var camera : Camera2D = $Camera2D
@onready var dialog_manager : Control = $Camera2D/DialogCanvasLayer/DialogManager

enum State {IDLE, WALK, SPRINT, DIALOG}

@export var inv: Inv

var current_state = State.IDLE
var input : Vector2
var speed = walk_speed
var playback : AnimationNodeStateMachinePlayback
var entering_combo : bool = false
var is_walking : bool = false

func _ready() -> void:
	PuzzleManager.inv = inv
	PuzzleManager.dialog = dialog_manager
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
		pass
		#camera.start_screen_shake(1.0, 1.0)
	
func select_animation() -> void:
	if velocity == Vector2.ZERO:
		change_state(State.IDLE)
		playback.travel("Idle")
		is_walking = false
		AudioGlobal.stopFootstep()
	else:
		playback.travel("Walk")
		if !is_walking:
			AudioGlobal.playFootstep()
			is_walking = true

func update_animation_parameters() -> void:
	if input == Vector2.ZERO:
		return
	animation_tree["parameters/Idle/blend_position"] = input
	animation_tree["parameters/Walk/blend_position"] = input
	
func player_enter_dialog() -> void:
	AudioGlobal.stopFootstep()
	playback.travel("Idle")
	current_state = State.DIALOG
 
func player_exit_dialog() -> void:
	if !entering_combo:
		current_state = State.IDLE

#item interaction
func tryCollect(item):
	change_state(State.IDLE) # stops animation from continueing
	playback.travel("Idle")
	print("Collect: ", item.name)
	return PuzzleManager.tryPuzzle(item)

func _on_safe_start_combo() -> void:
	current_state = State.DIALOG
	entering_combo = true

func _on_safe_input_manual() -> void:
	current_state = State.IDLE
	entering_combo = false

func _on_safe_input_wrong() -> void:
	current_state = State.IDLE
	entering_combo = false
