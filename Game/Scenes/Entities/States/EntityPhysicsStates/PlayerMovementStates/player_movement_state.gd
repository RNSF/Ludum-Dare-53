class_name PlayerMovementState
extends EntityPhysicsState

var idle_animation := "idle";
var walk_animation := "walk";

func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"walking_speed",
		"walking_acceleration",
		"prev_animation",
	]);


func update(host: Node2D, delta: float):
	animate(host);
	return super.update(host, delta);

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

func animate(host: Node2D):
	var walking_direction : Vector2 = controls.get("Walking Direction", Vector2.ZERO);
	var new_animation := "";
	
	
	
	if(walking_direction.length() > 0):
		new_animation = walk_animation;
	else:
		new_animation = idle_animation;
	
	if(host.prev_animation != new_animation):
		host.animation_player.stop();
		host.animation_player.play(new_animation);
		host.prev_animation = new_animation;
