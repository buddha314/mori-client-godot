extends LogicNodeBase

@export var PROBABILITY: float
@export var NAME: String

func _ready() -> void:
	LOGIC_CLASS = "fact"
	set_slot(0, false, 1, Color.WHITE , true, 1, FACT_OUTPUT_SLOT_COLOR)

func _on_delete_request() -> void:
	queue_free()


func _on_text_edit_text_changed() -> void:
	NAME = $SlotContainer/TextEdit.text
	#print(NAME)

func _on_text_edit_2_text_changed() -> void:
	if (len( $HBoxContainer2/TextEdit2.text)) > 0:
		PROBABILITY = float($HBoxContainer2/TextEdit2.text)
		#print(PROBABILITY)
	else:
		PROBABILITY = 0.0

func _to_json() -> String:
	var j = {}
	j["fact"] =  find_child("NameInput").text
	j["probability"] = find_child("SlotValue").text
	#print(c.find_child("SlotLabel").text)
	#print(c.find_child("SlotValue").text)
	return JSON.stringify(j)
	
