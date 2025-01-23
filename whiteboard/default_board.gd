extends Control

var relation_node: PackedScene = preload("res://whiteboard/relation_node.tscn")
var fact_node: PackedScene = preload("res://whiteboard/fact_node.tscn")
var and_node: PackedScene = preload("res://whiteboard/and_node.tscn")

var initial_position = Vector2(40,40);
var NUM_RELATIONS: int = 0
var NUM_FACTS: int = 0
var NUM_RULES: int = 0

func _ready() -> void:
	pass

func _on_add_relation_pressed() -> void:
	#print("ur mama")
	var node = relation_node.instantiate()
	node.name = "relation_%d" % NUM_RELATIONS
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_RELATIONS += 1


func _on_add_fact_pressed() -> void:
	#print("In case you didn't know...")
	var node = fact_node.instantiate()
	node.name = "factnode_%d" % NUM_FACTS
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_FACTS += 1	

func _on_add_and_pressed() -> void:
	print("Creating AND Node")
	var node = and_node.instantiate()
	node.name = "rulenode_%d" % NUM_RULES
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_RULES +=1

func _on_graph_edit_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	print("Connection Request to port -> " + str(to_port))
	var fn: LogicNodeBase
	var tn: LogicNodeBase
	print($GraphEdit.get_children())

	for n in $GraphEdit.get_children():
		if n.name == from_node:
			#print("Found your fkn kid")
			fn = n		
		if n.name == to_node:
			tn = n
	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)
	print("Actual to slot? " + str(to_port))
	print("How many input ports right now? " + str(tn.NUM_SLOTS_DEFAULT))
	#print(tn.get_child(tn.NUM_SLOTS_DEFAULT + to_port))
	#print(tn.get_child(tn.NUM_SLOTS_DEFAULT + to_port).find_child("TextEdit"))
	
	# This feels like a kludge
	tn.get_child(tn.NUM_SLOTS_DEFAULT + to_port).find_child(
		"SlotName"
		).set_text(
			fn.get_node("NameContainer/NameInput").text
	)



func _on_run_pressed() -> void:
	print("\n conx")
	print($GraphEdit.get_connection_list())
	print("\n children")
	print($GraphEdit.get_children())

	var nodes = {}	
	for c in $GraphEdit.get_children():
		print("Child: ")
		print(c)
		print(c.name)
		#if c.name.begins_with("factnode"):
		if c.get_class().begins_with("GraphNode"):
			var j = {}
			#j["name"] = c.name
			j["class"] = c.get_class()
			#print(c._to_json())
			j["data"] = JSON.parse_string(c._to_json())
			#print(j)
			nodes[c.name] = j
			#print(nodes)
	
	for x in $GraphEdit.get_connection_list():
		var f = $GraphEdit.find_child(x['from_node'])
		#print(x['from_node'])
		var t = $GraphEdit.find_child(x['to_node'])
	
	var logic_graph = {}
	logic_graph["nodes"] = nodes
	logic_graph["edges"] = $GraphEdit.get_connection_list()
	print(logic_graph)
	
	
