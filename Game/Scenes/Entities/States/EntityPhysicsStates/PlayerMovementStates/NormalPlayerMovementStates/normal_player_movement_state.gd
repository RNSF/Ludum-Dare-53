class_name NormalPlayerMovementState
extends PlayerMovementState


func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"normal_walking_speed",
	]);
	
	host.walking_speed = host.normal_walking_speed;


