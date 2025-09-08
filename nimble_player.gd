extends CharacterBody2D
@export var friction := 8
@export var walk_accel := 20
@export var walk_speed := 50
@export var air_friction := 0
@export var air_accel := 10
@export var air_speed := 50
@export var tumble_speed := 200
@export var jump_speed := -140

@export var state_machine : CharacterStateMachine
@export var anim_player : AnimationPlayer
@export var sprite : Sprite2D
@export var weapon : CloudBurst
@export var shot_points : Node2D

@export var bobs : Array[Sprite2D]

var facing = 1

var aim = 0

func _ready():
	state_machine.start_state_machine(NimbleIdleState.new(), self)
	
func anim_play(anim):
	anim_player.play(anim)
func check_flip():
	var lr_input = Input.get_axis("left", "right")
	if (lr_input != 0) and (sign(lr_input) != sign(facing)):
		facing *= -1
		sprite.flip_h = !sprite.flip_h
		for bob in bobs:
			bob.flip_h = !sprite.flip_h
		shot_points.scale = shot_points.scale * Vector2(-1, 1)
func _physics_process(_delta):
	move_and_slide()
