extends Control

#@onready var inv: Inv = preload("res://Inventory/playerInv.tres").duplicate()
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@export var player: Node
var inv: Inv


var is_open = false

func _ready():
	inv = player.inv
	inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	#goes through all the slots and update it
	print("slotttt")
	print("inv.slots.size():", inv.slots.size())
	print("slots.size():", slots.size())
	"""for i in range(min(inv.slots.size(), slots.size())):
		print("Slot", i, "item", inv.slots[i].item)
		print("Updating slot node:", slots[i].name)
		slots[i].update(inv.slots[i])"""

func _process(_delta: float):
	if Input.is_action_just_pressed("i"):
		print("Works")
		if is_open:
			close()
		else:
			open()

func open():
	self.visible = true
	is_open = true

func close():
	visible = false
	is_open = false
