class_name AimPlayerMovementState
extends CarryPlayerMovementState


func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"aim_walking_speed",
		"aiming_line",
	]);
	
	host.walking_speed = host.aim_walking_speed;


func update(host: Node2D, delta: float):
	var result = super.update(host, delta);
	if(result != null):
		return result;
	var aim_point = controls.get("Aim Point");
	"""
	if(host.picked_up_package != null and aim_point != null):
		host.picked_up_package.z_index = host.z_index + sign(host.global_position.y - aim_point.y);
	"""
	handle_package(host, aim_point);
	
	if(aim_point == null):
		return "CarryPlayerMovementState"
	
	if(host.picked_up_package == null):
		return "NormalPlayerMovementState"

func physics_update(host: Node2D, delta: float):
	host.aiming_line.points_3D = host.picked_up_package.throw_line_points;
	return super.physics_update(host, delta);


func handle_package(host: Node2D, aim_point) -> void:
	host.picked_up_package.aim(aim_point, host.throw_strength);
	if(controls.get("Throw", false)):
		host.picked_up_package.throw();
		host.picked_up_package.z_index = host.z_index;
		host.picked_up_package = null;

func exit(host: Node2D) -> void:
	var empty :  Array[Vector3];
	host.aiming_line.points_3D = empty;
