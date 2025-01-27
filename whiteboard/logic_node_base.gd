extends GraphNode
class_name LogicNodeBase

@export var FACT_OUTPUT_SLOT_COLOR: Color = Color.DARK_CYAN
@export var RULE_INPUT_SLOT_COLOR: Color = Color.DARK_ORANGE
@export var RELATION_SLOT_OUT_COLOR: Color = Color.DARK_GOLDENROD
@export var NUM_SLOTS_DEFAULT: int

var LOGIC_CLASS: String = "base"

func _on_graph_edit_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	print("[LNB] Connection Request to port -> " + str(to_port))

func _on_delete_request() -> void:
	queue_free()

func _to_json() -> String:
	return ""
	
func _from_json(j: Dictionary) -> GraphNode:
	return GraphNode.new()
