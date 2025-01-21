extends Control

@export var FACT_SLOT_COLOR: Color
@export var RELATION_SLOT_OUT_COLOR: Color
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
	node.RELATION_SLOT_OUT_COLOR = RELATION_SLOT_OUT_COLOR
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_RELATIONS += 1


func _on_add_fact_pressed() -> void:
	#print("In case you didn't know...")
	var node = fact_node.instantiate()
	node.name = "factnode_%d" % NUM_FACTS
	node.FACT_SLOT_COLOR = FACT_SLOT_COLOR
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_FACTS += 1	

func _on_graph_edit_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	print("Connection Request to port -> " + str(to_port))
	var fn: GraphNode
	var tn: GraphNode
	print($GraphEdit.get_children())

	for n in $GraphEdit.get_children():
		if n.name == from_node:
			#print("Found your fkn kid")
			fn = n		
		if n.name == to_node:
			tn = n
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)
	#print("Actual to slot? " + str(to_port))
	#print("How many input ports right now? " + str(tn.get_input_port_count()))
	#print(tn.get_child(tn.NUM_SLOTS_DEFAULT + to_port))
	#print(tn.get_child(tn.NUM_SLOTS_DEFAULT + to_port).find_child("TextEdit"))
	
	# This feels like a kludge
	tn.get_child(tn.NUM_SLOTS_DEFAULT + to_port).find_child("TextEdit").set_text(
		fn.get_node("HBoxContainer2/TextEdit").text
	)
