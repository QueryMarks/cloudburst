extends Node2D
class_name SaveGame


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func save():
	var save_dict = {
		"pos_x" : position.x,
		"pos_y" : position.y
	}
	return save_dict

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var node_data = save()
	var json_string = JSON.stringify(node_data)
	save_file.store_line(json_string)
	
