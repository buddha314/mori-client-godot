extends Control



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui-toggle"):
		$SpaceBarHint.visible = !$SpaceBarHint.visible
		#$MenuButton.visible = !$MenuButton.visible
		$MenuContainer.visible = !$MenuContainer.visible
