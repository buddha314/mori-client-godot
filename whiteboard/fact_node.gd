extends LogicNodeBase
class_name FactNode

@export var PROBABILITY: float
@export var NAME: String
const self_scene: PackedScene = preload("res://whiteboard/fact_node.tscn")

func _ready() -> void:
	LOGIC_CLASS = "fact"
	NUM_SLOTS_DEFAULT = 1
	resizable = true
	set_slot(0, false, 1, Color.WHITE , true, 1, FACT_OUTPUT_SLOT_COLOR)

func _on_delete_request() -> void:
	queue_free()

func _on_text_edit_text_changed() -> void:
	NAME = $SlotContainer/TextEdit.text
	#print(NAME)

func _on_text_edit_2_text_changed() -> void:
	if (len( $SlotContainer/SlotValue.text)) > 0:
		PROBABILITY = float($SlotContainer/SlotValue.text)
		#print(PROBABILITY)
	else:
		PROBABILITY = 0.0

func _to_json() -> Dictionary:
	var j = super()
	j["fact"] =  find_child("NameInput").text
	j["probability"] = find_child("SlotValue").text
	return j

static func constructor(j: Dictionary) -> FactNode:
	var obj = self_scene.instantiate()
	obj.title = "Fact Node"
	obj.name = j["id"]
	obj.unique_name_in_owner = true
	obj.find_child("NameInput").text = j["fact"]
	obj.find_child("SlotValue").text = str(j["probability"])
	return obj
	
