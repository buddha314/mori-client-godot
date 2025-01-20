extends GraphNode

@export var FACT_SLOT_COLOR: Color
@export var PROBABILITY: float
@export var NAME: String

func _ready() -> void:
	set_slot(1, false, 1, FACT_SLOT_COLOR , true, 1, FACT_SLOT_COLOR)

func _on_delete_request() -> void:
	queue_free()
