extends Control

@export var FACT_SLOT_COLOR: Color
var relation_node: PackedScene = preload("res://whiteboard/relation_node.tscn")
var fact_node = preload("res://whiteboard/fact_node.tscn")

var initial_position = Vector2(40,40);
var NUM_RELATIONS: int = 0
var NUM_FACTS: int = 0

func _ready() -> void:
	pass

func _on_add_relation_pressed() -> void:
	#print("ur mama")
	var node = relation_node.instantiate()
	node.name = "relation_%d" % NUM_RELATIONS
	node.FACT_SLOT_COLOR = FACT_SLOT_COLOR
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_RELATIONS += 1


func _on_add_fact_pressed() -> void:
	print("In case you didn't know...")
	var node = fact_node.instantiate()
	node.name = "factnode_%d" % NUM_FACTS
	node.FACT_SLOT_COLOR = FACT_SLOT_COLOR
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_FACTS += 1	
	#print($GraphEdit.get_child(1))

func _on_graph_edit_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	print("Connection Request")
	var fn: GraphNode
	var tn: GraphNode
	for n in $GraphEdit.get_children():
		if n.name == from_node:
			print("Found your fkn kid")
			fn = n
			print(fn)
			print(fn.get_node("HBoxContainer2/TextEdit").text)
			#print(fn.get_method_list())
		elif n.name == to_node:
			tn = n
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)
	tn.get_node("TextEdit").set_text(
		fn.get_node("HBoxContainer2/TextEdit").text
	)
	print($GraphEdit.get_children())
