extends Control

@onready var countDown = $Label
@onready var timer = $WorldTimer

func _ready():
	timer.start()
	
func time_left_living():	
	var time_left = timer.time_left
	var minute = floor(time_left/60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _process(_delta: float) -> void:
	countDown.text = "%02d:%02d" % time_left_living()
