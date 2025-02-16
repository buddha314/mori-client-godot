extends GraphNode
class_name LogicNode

@export var FACT_OUTPUT_SLOT_COLOR: Color = Color.DARK_CYAN
@export var RULE_INPUT_SLOT_COLOR: Color = Color.DARK_ORANGE
@export var RELATION_SLOT_OUT_COLOR: Color = Color.DARK_GOLDENROD
@export var NUM_SLOTS_DEFAULT: int = 0
var NUM_SLOTS = 0
var LOGIC_CLASS: String = "base"

func _ready() -> void:
	set_unique_name_in_owner(true)

func _on_graph_edit_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	print("[LNB] Connection Request to port -> " + str(to_port))

func _on_delete_request() -> void:
	queue_free()

func _to_json() -> Dictionary:
	var j = {}
	j["n_input_ports"] = get_input_port_count()
	j["n_output_ports"] = get_output_port_count()
	j["id"] = name
	j["class"] = self.get_class()
	j["logic_class"] = LOGIC_CLASS 
	return j

static func constructor(j: Dictionary) -> LogicNodeBase:
	return LogicNodeBase.new()
