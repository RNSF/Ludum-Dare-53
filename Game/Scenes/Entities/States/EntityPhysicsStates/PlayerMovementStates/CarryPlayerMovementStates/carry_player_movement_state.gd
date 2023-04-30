class_name CarryPlayerMovementState
extends PlayerMovementState


func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"carry_walking_speed",
	]);
	
	host.walking_speed = host.carry_walking_speed;
	if(host.picked_up_package):
		host.picked_up_package.z_index = host.z_index - 1;


func update(host: Node2D, delta: float):
	var result = super.update(host, delta);
	if(host.picked_up_package == null):
		return "NormalPlayerMovementState";
	if(controls.get("Start Aim")):
		return "AimPlayerMovementState"
	return result
