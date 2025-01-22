extends LogicNodeBase

@export var PROBABILITY: float
@export var NAME: String

func _ready() -> void:
	set_slot(1, false, 1, Color.WHITE , true, 1, FACT_OUTPUT_SLOT_COLOR)

func _on_delete_request() -> void:
	queue_free()


func _on_text_edit_text_changed() -> void:
	NAME = $HBoxContainer2/TextEdit.text
	#print(NAME)

func _on_text_edit_2_text_changed() -> void:
	if (len( $HBoxContainer2/TextEdit2.text)) > 0:
		PROBABILITY = float($HBoxContainer2/TextEdit2.text)
		#print(PROBABILITY)
	else:
		PROBABILITY = 0.0
