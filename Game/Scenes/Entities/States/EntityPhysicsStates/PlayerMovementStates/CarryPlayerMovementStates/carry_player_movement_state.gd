class_name CarryPlayerMovementState
extends PlayerMovementState


func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"carry_walking_speed",
	]);
	
	host.walking_speed = host.carry_walking_speed;
