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
	var nodes = []	
	for c in $GraphEdit.get_children():
		if c.get_class().begins_with("GraphNode"):
			var j = {}
			j["id"] = c.name
			j["logic_class"] = c.LOGIC_CLASS
			j["class"] = c.get_class()
			j["data"] = JSON.parse_string(c._to_json())
			nodes.append(j)
	
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
			
func _on_load_pressed() -> void:
	_load_data()
