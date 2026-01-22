extends Node
class_name CloudBurst

@export var shot := preload("res://scenes/cloud_shot.tscn")
@export var shot_speed := 5
@export var shot_point_h : Node2D
@export var shot_point_u : Node2D
@export var shot_point_d : Node2D
@export var recoil_h := Vector2(-200, -120)
@export var recoil_u := Vector2(0, 160)
@export var recoil_d := Vector2(0, -160)
@export var max_shots := 3
@export var player : CharacterBody2D
var shots
var active_shots := []
		

func shoot():
	if shots > 0:
			var shot_point
			if player.aim < 0:
				shot_point = shot_point_u
			elif player.aim > 0:
				shot_point = shot_point_d
			elif player.aim == 0:
				shot_point = shot_point_h
			var real_shot = shot.instantiate()
			owner.add_child(real_shot)
			active_shots.append(real_shot)
			real_shot.shot_velocity = shot_speed
			real_shot.global_transform = shot_point.global_transform
			shots -= 1
func air_shoot():
	if shots > 0:
		shoot()
		if player.aim < 0:
			player.velocity.y += recoil_u.y
		elif player.aim > 0:
			player.velocity.y = recoil_d.y
		elif player.aim == 0:
			player.velocity.x += recoil_h.x * player.facing
			player.velocity.y = recoil_h.y
		player.state_machine.change_state(NimbleTumbleState.new())
	
func _physics_process(_delta):
	if player.is_on_floor():
		shots = max_shots
