class_name EntityPhysicsState
extends EntityState

func enter(host: Node2D):
	super.enter(host);
	required_host_variables.append_array([
		"friction",
		"velocity",
		"acceleration"
	]);

func physics_update(host: Node2D, delta: float):
	apply_acceleration(host, delta);
	apply_friction(host, delta);
	reset_acceleration(host);
	return super.physics_update(host, delta);

func apply_acceleration(host: Node2D, delta: float) -> void: 
	var acceleration : Vector2 = host.acceleration;
	host.velocity += acceleration * delta;


func apply_friction(host: Node2D, delta: float) -> void:
	var max_friction : float = host.velocity.normalized() * host.friction * delta;
	host.velocity -= min(max_friction, host.velocity.length()) * host.velocity.normalized();

func reset_acceleration(host: Node2D) -> void:
	host.accleration = Vector2.ZERO;
