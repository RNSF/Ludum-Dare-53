class_name EntityPhysicsState
extends EntityState

func enter(host: Node2D):
	super.enter(host);
	required_host_variables.append_array([
		"friction",
		"velocity",
		"acceleration",
		"z_position",
		"z_velocity",
		"z_acceleration",
		"gravity"
	]);

func physics_update(host: Node2D, delta: float):
	apply_physics(host, delta);
	return super.physics_update(host, delta);


func apply_physics(host: Node2D, delta: float) -> void:
	apply_acceleration(host, delta);
	apply_friction(host, delta);
	reset_acceleration(host);
	apply_gravity(host);
	apply_z_acceleration(host, delta);
	reset_z_acceleration(host);

func apply_acceleration(host: Node2D, delta: float) -> void: 
	var acceleration : Vector2 = host.acceleration;
	host.velocity += acceleration * delta;


func apply_friction(host: Node2D, delta: float) -> void:
	var max_friction : float = host.friction * delta;
	host.velocity -= min(max_friction, host.velocity.length()) * host.velocity.normalized();

func reset_acceleration(host: Node2D) -> void:
	host.acceleration = Vector2.ZERO;

func apply_gravity(host: Node2D)  -> void:
	host.z_acceleration -= host.gravity;

func apply_z_acceleration(host: Node2D, delta: float) -> void: 
	host.z_velocity += host.z_acceleration*delta;

func reset_z_acceleration(host: Node2D) -> void:
	host.z_acceleration = 0;
