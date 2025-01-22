extends LogicNodeBase

#@export var RULE_INPUT_NODE_COLOR: Color
var RULE_INPUT_SLOT_TEMPLATE = load("res://whiteboard/rule_input_slot.tscn")

func _ready() -> void:
	pass
	
func _on_button_pressed() -> void:
	print("Adding new input to rule")
	var n = RULE_INPUT_SLOT_TEMPLATE.instantiate()
	set_slot(get_child_count(), true, 1, RULE_INPUT_SLOT_COLOR, false, 1, Color.WHITE)
	add_child(n)
