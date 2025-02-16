extends Control

@onready var NODEMENU: MenuButton = $MenuContainer/NodeMenuButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_node_menu_items(NODEMENU)	
	pass # Replace with function body.

func set_node_menu_items(MENU: MenuButton) -> void:
	var popup = MENU.get_popup()
	popup.add_item("Fact Node", 1)
	popup.add_item("Rule Node", 2)
	popup.add_item("Logic Node", 3)

	#var global_position = NODEMENU.global_position
	#var pop_position = Vector2(global_position.x + MENU.size.x, global_position.y)
	#popup.position = pop_position
	# Move options to the side
	MENU.about_to_popup.connect(_set_popup_location)
	
	# Set the signal emission
	popup.id_pressed.connect(_on_node_menu_item_selected)


func _on_node_menu_item_selected(option_id):
	print("Logic node added: %d" % option_id)
	emit_signal("logic_node_added", option_id)

func _set_popup_location():
	print("about to pop")
	var popup = NODEMENU.get_popup()
	var global_position = NODEMENU.global_position
	print(global_position)
	var menu_size = NODEMENU.size
	print(menu_size)

	# Set popup position to appear to the right of the button
	#var pop_position = Vector2(global_position.x + menu_size.x, global_position.y)
	var pop_position = Vector2(250, 40)
	print(pop_position)
	#popup.position = pop_position
	popup.set_position(pop_position)

	# Ensure the popup is visible after repositioning
	popup.popup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui-toggle"):
		$SpaceBarHint.visible = !$SpaceBarHint.visible
		#$MenuButton.visible = !$MenuButton.visible
		$MenuContainer.visible = !$MenuContainer.visible
