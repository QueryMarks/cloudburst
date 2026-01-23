extends Node
func _input(event):
	if event.is_action_pressed("pause"):
		self.visible = !self.visible
		get_tree().paused = !get_tree().paused
