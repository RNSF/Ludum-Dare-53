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
	if(host.velocity.length() < host.walking_speed):
		var walking_direction : Vector2 = controls.get("Walking Direction", Vector2.ZERO);
		host.acceleration += host.walking_acceleration * walking_direction;
