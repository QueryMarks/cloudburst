extends Camera2D

@export var tilemap : TileMapLayer

func _ready():
	change_bounds(tilemap)
	make_current()
	print(is_current())

func change_bounds(tiles):
	var rect = tilemap.get_used_rect()
	limit_left = rect.position.x*8
	limit_top = rect.position.y*8
	limit_right = rect.end.x*8
	limit_bottom = rect.end.y*8
	print("left: " + str(limit_left))
	print("right: " + str(limit_right))
	print("top: " + str(limit_top))
	print("bottom: " + str(limit_bottom))
func _physics_process(delta: float) -> void:
	#print(global_position)
	pass
