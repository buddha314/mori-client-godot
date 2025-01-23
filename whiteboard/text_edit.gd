extends TextEdit
class_name GraphTextInput

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER:			
			var input_value = text.strip_edges()
			print("Input value set to:", input_value)
			# Prevent adding a new line
			accept_event()
