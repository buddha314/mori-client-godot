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
	var j = {}
	j["id"] = "relation_%d" % NUM_RELATIONS
	j["relation"] = "new relation (%d)" % NUM_RELATIONS
	j["n_input_ports"] = 1
	var node = RelationNode.constructor(j)
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_RELATIONS += 1


func _on_add_fact_pressed() -> void:
	#print("In case you didn't know...")
	var j = {}
	j["id"] = "factnode_%d" % NUM_FACTS
	j["fact"] = "new fact (%d)" % NUM_FACTS
	j["probability"] = 0.5
	var node = FactNode.constructor(j)
	#var node = fact_node.instantiate()
	#node.name = "factnode_%d" % NUM_FACTS
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_FACTS += 1	

func _on_add_and_pressed() -> void:
	print("Creating AND Node")
	var j = {}
	j["id"] = "rulenode_%d" % NUM_RULES
	j["rule"] = "new rule (%d)" % NUM_RULES
	j["n_input_ports"] = 1
	var node = RuleAnd.constructor(j)
	node.position_offset = initial_position
	$GraphEdit.add_child(node)
	NUM_RULES +=1

func _on_graph_edit_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	_find_and_connect_nodes(from_node, from_port, to_node, to_port)
	
func _find_and_connect_nodes(from_node, from_port, to_node, to_port) -> void:
	print("Connecting %s:%s -> %s:%s" % [from_node, from_port, to_node, to_port])
	var fn: LogicNodeBase = $GraphEdit.get_node(NodePath(from_node))
	#var fn: LogicNodeBase = $GraphEdit.find_child(from_node)
	var tn: LogicNodeBase = $GraphEdit.get_node(NodePath(to_node))
	print(fn)
	print(tn)

	$GraphEdit.connect_node(from_node, from_port, to_node, to_port)
	#$GraphEdit.connect_node(fn.name, from_port, tn.name, to_port)
	# This feels like a kludge
	print(tn.get_input_port_slot(to_port))
	tn.get_child(tn.get_input_port_slot(to_port)).find_child(
		"SlotName"
	).set_text(
			fn.get_node("NameContainer/NameInput").text		
	)

func _on_run_pressed() -> void:
	var nodes = []	
	for c in $GraphEdit.get_children():
		if c.get_class().begins_with("GraphNode"):
			nodes.append(c._to_json())
	
	var logic_graph = {}
	logic_graph["client"] = "mori-godot"
	logic_graph["nodes"] = nodes
	logic_graph["edges"] = $GraphEdit.get_connection_list()
	_write_data(logic_graph, "whiteboard.json")
	#print(JSON.stringify(logic_graph, "  "))
	

func _write_data(logic_graph: Dictionary, file_name: String = "whiteboard.json") -> void:
	var file = FileAccess.open("res://data/%s" % file_name, FileAccess.WRITE)
	var t: String = JSON.stringify(logic_graph, "  ")
	print(t)
	file.store_string(t)

func _load_data(file_name: String = "whiteboard.json") -> void:
	var file = FileAccess.open("res://data/%s" % file_name, FileAccess.READ)
	var j = JSON.new()
	var j_err = j.parse(file.get_as_text())
	var j_obj = j.get_data()
	for n in j_obj["nodes"]:
		#print(n)
		if n["logic_class"] == "fact":
			var x: FactNode = FactNode.constructor(n)
			$GraphEdit.add_child(x)
		elif n["logic_class"] == "relation":
			var x: RelationNode = RelationNode.constructor(n)
			$GraphEdit.add_child(x)
		elif n["logic_class"] == "rule_and":
			var x: RuleAnd = RuleAnd.constructor(n)
			$GraphEdit.add_child(x)
	
	for n in j_obj["edges"]:
		print(n)
		_find_and_connect_nodes(
			n["from_node"],
			n["from_port"],
			n["to_node"],
			n["to_port"])
			
func _on_load_pressed() -> void:
	_load_data()
