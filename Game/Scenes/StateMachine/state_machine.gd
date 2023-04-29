class_name StateMachine
extends Node

var current_state : State = null;
var states := {};
var old_states := [];

func setup(host: Node2D) -> void:
	if(len(get_children()) > 0):
		var state = get_child(0);
		change_state(host, state.name);
			

func update(host: Node2D, delta: float) -> void:
	if(current_state != null):
		var state_name = current_state.update(host, delta);
		if(state_name != null):
			change_state(host, state_name);

func physics_update(host: Node2D, delta: float) -> void:
	if(current_state != null):
		var state_name = current_state.physics_update(host, delta);
		if(state_name != null):
			change_state(host, state_name);

func change_state(host: Node2D, state_name: String) -> void:
	if(current_state != null):
		current_state.exit(host);
	
	var new_state : Node = null;
	if(state_name == "_previous"):
		if(len(old_states) > 0):
			new_state = old_states.pop_back();
		else:
			new_state = get_child(0);
			print("STATE ERROR: No previous state to return to");
	else:
		new_state = get_node(state_name);
		if(new_state.track_old):
			old_states.append(current_state);
		else:
			old_states.clear();
	
	current_state = new_state;
	current_state.enter(host);
