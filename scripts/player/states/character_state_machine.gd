extends Node

class_name CharacterStateMachine

var current_state : State
var player

func start_state_machine(start_state, given_player):
	player = given_player
	change_state(start_state)

func change_state(new_state : State):
	if current_state != null:
		current_state.exit()
		current_state.queue_free()
	current_state = new_state
	current_state.player = player
	current_state.state_machine = self
	self.add_child(current_state)
	current_state.enter()
