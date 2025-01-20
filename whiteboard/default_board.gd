extends Control

@export var FACT_SLOT_COLOR: Color
var relation_node = load("res://whiteboard/relation_node.tscn")
var fact_node = load("res://whiteboard/fact_node.tscn")

var initial_position = Vector2(40,40);

func _ready() -> void:
	pass

func _on_add_relation_pressed() -> void:
	print("ur mama")
	var node = relation_node.instantiate()
	node.FACT_SLOT_COLOR = FACT_SLOT_COLOR
	node.position_offset = initial_position
	$GraphEdit.add_child(node)


func _on_add_fact_pressed() -> void:
	print("In case you didn't know...")
	var node = fact_node.instantiate()
	node.FACT_SLOT_COLOR = FACT_SLOT_COLOR
	node.position_offset = initial_position
	$GraphEdit.add_child(node)


func _on_graph_edit_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)
