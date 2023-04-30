class_name EntityPathState
extends EntityState

func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"path_follow",
		"walk_speed",
		"path",
	]);

func physics_update(host: Node2D, delta: float):
	var result = super.physics_update(host, delta);
	
	host.path.global_position = Vector2.ZERO;
	host.path_follow.progress += host.walk_speed * delta;
	host.velocity = (host.path_follow.global_position - host.global_position) / delta;
	
	
	return result;



