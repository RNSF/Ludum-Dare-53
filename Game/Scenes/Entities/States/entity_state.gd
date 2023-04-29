class_name EntityState
extends State

var controls := {};

func enter(host: Node2D) -> void:
	required_host_variables.append_array([
		"animation_player",
		"character_body_2d",
	]);
	super.enter(host);
