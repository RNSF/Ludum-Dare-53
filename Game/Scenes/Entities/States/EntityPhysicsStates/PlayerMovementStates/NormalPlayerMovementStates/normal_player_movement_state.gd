class_name NormalPlayerMovementState
extends PlayerMovementState


func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"normal_walking_speed",
		"package_detector",
		"package_z_position",
	]);
	
	host.walking_speed = host.normal_walking_speed;

func physics_update(host: Node2D, delta: float):
	handle_package(host);
	return super.physics_update(host, delta);



func handle_package(host: Node2D) -> void:
	var package : Package = host.package_detector.highlighted_package;
	if(package == null):
		return
	
	if(controls.get("Pick Up")):
		package.pick_up(host, host.package_z_position);




