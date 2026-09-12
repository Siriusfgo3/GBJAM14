extends Panel

@onready var item_visual: Sprite2D =$CenterContainer/Panel/item_sprite
@onready var amount_label: Label = $CenterContainer/Panel/Label


func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		amount_label.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_label.visible = true
		amount_label.text = str(slot.amount)
