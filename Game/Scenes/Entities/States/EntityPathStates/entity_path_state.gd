class_name EntityPathState
extends EntityState

func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"path_follow",
		"walk_speed",
		"path",
		"ping_pong",
		"go_reverse",
	]);

func physics_update(host: Node2D, delta: float):
	var result = super.physics_update(host, delta);
	
	host.path.global_position = Vector2.ZERO;
	host.path_follow.progress += host.walk_speed * delta;
	if(!host.path_follow.loop and (host.path_follow.progress_ratio <= 0.0 or host.path_follow.progress_ratio >= 1.0)):
		host.go_reverse = !host.go_reverse;
		
	host.velocity = (host.path_follow.global_position - host.global_position) / delta;
	
	
	return result;



