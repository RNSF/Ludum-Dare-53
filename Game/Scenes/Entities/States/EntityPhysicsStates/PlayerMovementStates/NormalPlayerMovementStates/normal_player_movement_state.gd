class_name NormalPlayerMovementState
extends PlayerMovementState


func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"normal_walking_speed",
		"package_detector",
		"package_z_position",
		"picked_up_package",
	]);
	
	host.walking_speed = host.normal_walking_speed;

func update(host: Node2D, delta: float):
	var result = super.update(host, delta);
	handle_package(host);
	if(host.picked_up_package):
		return "CarryPlayerMovementState";
	return result



func handle_package(host: Node2D) -> void:
	var package : Package = host.package_detector.highlighted_package;
	if(package == null):
		return
	
	if(controls.get("Pick Up", false)):
		package.pick_up(host, host.package_z_position);
		host.picked_up_package = package;




