extends LogicNodeBase
class_name RelationNode

var SLOT_TEMPLATE = load("res://whiteboard/relation_node_fact_slot.tscn")
const self_scene: PackedScene = preload("res://whiteboard/relation_node.tscn")

@export var ARITY: int = 1
@export var ARITY_TYPES: Array[String]

func _ready() -> void:
	LOGIC_CLASS = "relation"
	NUM_SLOTS_DEFAULT = get_child_count()-1
	$HBoxContainer2/SpinBox.value = ARITY
	#print("Number of children at ready -> " + str(get_child_count()))
	ARITY_TYPES =  ["str", "str"]
	for i in len(ARITY_TYPES):
		var l = RichTextLabel.new()
		l.add_text("I am entry: " + str(i))
		l.fit_content = true
		$HBoxContainer3/VBoxContainer.add_child(l)
		#print("Need a box here, I guess")
	set_slot(0, false, 1, FACT_OUTPUT_SLOT_COLOR , true, 1, RULE_INPUT_SLOT_COLOR)

func _on_delete_request() -> void:
	queue_free() # Replace with function body.

func _on_add_fact_pressed() -> void:
	_add_input_slots(1)
	
func _add_input_slots(n_inputs: int) -> void:
	for i in n_inputs:
		print("Current have %d slots" )
		var f = SLOT_TEMPLATE.instantiate()
		add_child(f)
		set_slot(get_child_count()-1, true, 1, FACT_OUTPUT_SLOT_COLOR, false, 1, Color.WHITE)
	
func _to_json() -> Dictionary:
	var j = super()
	j["logic_class"] = LOGIC_CLASS
	j["relation"] = find_child("NameInput").text
	j["arity_types"] = ARITY_TYPES
	return j

static func constructor(j: Dictionary) -> RelationNode:
	#print("relation node")
	#print(j)
	var obj = self_scene.instantiate()
	obj.name = j["id"]
	obj.unique_name_in_owner = true
	obj.find_child("NameInput").text = j["relation"]
	obj._add_input_slots(j["n_input_ports"])
	return obj
	
