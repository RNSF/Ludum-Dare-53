class_name PlayerMovementState
extends EntityPhysicsState


func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"walking_speed",
		"walking_acceleration"
	]);

func physics_update(host: Node2D, delta: float):
	apply_walking_force(host, delta);
	return super.physics_update(host, delta);


func apply_walking_force(host: Node2D, delta: float):
	var walking_direction : Vector2 = controls.get("Walking Direction", Vector2.ZERO);
	var target_velocity : Vector2 = walking_direction * host.walking_speed;
	var acceleration_direction : Vector2 = (target_velocity - host.velocity).normalized();
	var is_slowing_down : bool = host.velocity.dot(acceleration_direction) < 0;
	var walking_acceleration : float = host.walking_acceleration if !is_slowing_down else min(host.walking_acceleration, host.velocity.length()/delta)
	host.acceleration += walking_acceleration * (target_velocity - host.velocity).normalized();
