extends Node2D

var player
@export var tilemap : TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var player_spawn = self.position
	var player_scene = preload("res://nimble.tscn")
	if FileAccess.file_exists("user://savegame.save"):
		var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
		while save_file.get_position() < save_file.get_length():
			var json_string = save_file.get_line()

			# Creates the helper class to interact with JSON.
			var json = JSON.new()

			# Check if there is any error while parsing the JSON string, skip in case of failure.
			var parse_result = json.parse(json_string)
			if not parse_result == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
				continue

			# Get the data from the JSON object.
			var node_data = json.data
				
			player_spawn = Vector2(node_data["pos_x"], node_data["pos_y"])
		#set the player's position
		
	var player = player_scene.instantiate()
	player.position = player_spawn
	player.find_child("Camera2D").tilemap = tilemap
	add_child(player)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
