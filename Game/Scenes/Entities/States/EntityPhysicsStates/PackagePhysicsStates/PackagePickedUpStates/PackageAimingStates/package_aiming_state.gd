class_name PackageAimingState
extends PackagePickedUpState



func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"throw_line_points",
	]);

func physics_update(host: Node2D, delta: float):
	var result = super.physics_update(host, delta);
	simulate_throw(host);
	return result;



func simulate_throw(host: Node2D):
	
	var real_z_velocity = host.z_velocity;
	var real_velocity = host.velocity;
	var real_acceleration = host.acceleration;
	var real_z_acceleration = host.z_acceleration;
	var real_z_position = host.z_position;
	var real_position = host.global_position;
	
	host.z_velocity = host.aim_velocity.z;
	host.velocity = Vector2(host.aim_velocity.x, host.aim_velocity.y);
	host.acceleration = Vector2.ZERO;
	host.z_acceleration = 0.0;
	host.throw_line_points.clear();
	
	var real_collision_mask = host.character_body_2d.collision_mask;
	var real_collision_layer = host.character_body_2d.collision_layer;
	
	host.character_body_2d.collision_mask = host.temp_collision_mask;
	host.character_body_2d.collision_layer = host.temp_collision_layer;
	
	add_throwing_point(host);
	
	while(host.z_position > 0):
		apply_physics(host, 1.0/60.0);
		host.move(1.0/60.0, false);
		add_throwing_point(host);
	
	host.character_body_2d.collision_mask = real_collision_mask;
	host.character_body_2d.collision_layer = real_collision_layer;
	
	host.z_velocity = real_z_velocity;
	host.velocity = real_velocity;
	host.acceleration = real_acceleration;
	host.z_acceleration = real_z_acceleration;
	host.z_position = real_z_position;
	host.global_position = real_position;

func add_throwing_point(host: Node2D):
	var point := Vector3(
		host.global_position.x,
		host.global_position.y,
		host.z_position,
	);
	host.throw_line_points.append(point);
