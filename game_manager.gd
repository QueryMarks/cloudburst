extends Node2D

var player
@export var tilemap : TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_scene = preload("res://nimble.tscn")
	var player = player_scene.instantiate()
	player.find_child("Camera2D").tilemap = tilemap
	add_child(player)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
