extends LogicNodeBase
class_name RuleAnd

const self_scene: PackedScene = preload("res://whiteboard/and_node.tscn")
#@export var RULE_INPUT_NODE_COLOR: Color
var SLOT_TEMPLATE = load("res://whiteboard/rule_input_slot.tscn")

func _ready() -> void:
	LOGIC_CLASS = "rule_and"
	NUM_SLOTS_DEFAULT = get_child_count()
	
func _on_button_pressed() -> void:
	print("Adding new input to rule")
	_add_input_slots(1)
	
func _add_input_slots(n_inputs: int) -> void:
	for i in n_inputs:
		var f = SLOT_TEMPLATE.instantiate()
		add_child(f)
		set_slot(get_child_count()-1, true, 1, RELATION_SLOT_OUT_COLOR, false, 1, Color.WHITE)
	

func _to_json() -> Dictionary:
	var j = super()
	j["logic_class"] = LOGIC_CLASS
	j["relation"] = find_child("NameInput").text
	return j

static func constructor(j: Dictionary) -> RuleAnd:
	var obj = self_scene.instantiate()
	obj.name = j["id"]
	obj.unique_name_in_owner = true
	obj.find_child("NameInput").text = j["rule"]
	obj._add_input_slots(j["n_input_ports"])
	return obj
