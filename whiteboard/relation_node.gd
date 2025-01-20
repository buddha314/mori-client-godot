extends GraphNode

@export var FACT_SLOT_COLOR: Color
@export var ARITY: int = 1
@export var ARITY_TYPES: Array[int] = [0, 0]


func _ready() -> void:
	$VBoxContainer/HBoxContainer/SpinBox.value = ARITY
	ARITY_TYPES = [0,0]
	for i in len(ARITY_TYPES):
		var l = RichTextLabel.new()
		l.add_text("I am entry: " + str(i))
		l.fit_content = true
		$VBoxContainer/HBoxContainer2/VBoxContainer.add_child(l)
		print("Need a box here, I guess")
	set_slot(0, false, 1, FACT_SLOT_COLOR , false, 1, Color.BLUE_VIOLET)
	set_slot(1, true, 1, FACT_SLOT_COLOR , false, 1, Color.BLUE_VIOLET)


func _on_delete_request() -> void:
	queue_free() # Replace with function body.
