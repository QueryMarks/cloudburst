extends Area2D
@export var shot_velocity := 0
var timer = 0
func _physics_process(_delta):
	position += shot_velocity * Vector2.from_angle(rotation)
	timer += 1
	if timer >= 120:
		queue_free()
