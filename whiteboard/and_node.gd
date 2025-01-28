extends LogicNodeBase
class_name RuleAnd

const self_scene: PackedScene = preload("res://whiteboard/and_node.tscn")
#@export var RULE_INPUT_NODE_COLOR: Color
var RULE_INPUT_SLOT_TEMPLATE = load("res://whiteboard/rule_input_slot.tscn")

func _ready() -> void:
	LOGIC_CLASS = "rule_and"
	NUM_SLOTS_DEFAULT = get_child_count()
	
func _on_button_pressed() -> void:
	print("Adding new input to rule")
	var n = RULE_INPUT_SLOT_TEMPLATE.instantiate()
	set_slot(get_child_count(), true, 1, RULE_INPUT_SLOT_COLOR, false, 1, Color.WHITE)
	add_child(n)

func _to_json() -> String:
	var j = {}
	j["logic_class"] = LOGIC_CLASS
	j["relation"] = find_child("NameInput").text
	return JSON.stringify(j)

static func constructor(j: Dictionary) -> RuleAnd:
	var obj = self_scene.instantiate()
	return obj
