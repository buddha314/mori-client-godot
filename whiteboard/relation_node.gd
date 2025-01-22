extends GraphNode

var SLOT_TEMPLATE = load("res://whiteboard/relation_node_fact_slot.tscn")

@export var FACT_SLOT_COLOR: Color
@export var RELATION_SLOT_OUT_COLOR: Color
@export var RULE_INPUT_NODE_COLOR: Color
@export var ARITY: int = 1
@export var ARITY_TYPES: Array[int] = [0, 0]
@export var NUM_SLOTS_DEFAULT: int

func _ready() -> void:
	NUM_SLOTS_DEFAULT = get_child_count()
	$HBoxContainer2/SpinBox.value = ARITY
	#print("Number of children at ready -> " + str(get_child_count()))
	ARITY_TYPES = [0,0]
	for i in len(ARITY_TYPES):
		var l = RichTextLabel.new()
		l.add_text("I am entry: " + str(i))
		l.fit_content = true
		$HBoxContainer3/VBoxContainer.add_child(l)
		#print("Need a box here, I guess")
	set_slot(3, false, 1, FACT_SLOT_COLOR , true, 1, RULE_INPUT_NODE_COLOR)

func _on_delete_request() -> void:
	queue_free() # Replace with function body.

func _on_add_fact_pressed() -> void:
	#print("ADD ME BABY!!")
	var f = SLOT_TEMPLATE.instantiate()
	#print("Before add: #input ports -> " + str(get_input_port_count()))
	add_child(f)
	set_slot(get_child_count()-1, true, 1, FACT_SLOT_COLOR, false, 1, Color.BLUE_VIOLET)
	#print("After add: #input ports -> " + str(get_input_port_count()))
	
