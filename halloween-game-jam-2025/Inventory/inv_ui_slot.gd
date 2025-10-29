extends Panel


@onready var item_visual: Sprite2D = $CenterContainer/Panel/ItemDisplay
#@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	print("Updating")
	if slot.item == null:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		#amount_text.text = str(slot.amount)
