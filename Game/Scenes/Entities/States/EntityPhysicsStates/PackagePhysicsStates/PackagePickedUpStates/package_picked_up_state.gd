extends PackagePhysicsState


func enter(host: Node2D) -> void:
	required_host_variables.append_array([
		"picked_up_z_position",
		"picked_up_follow_speed",
		"picked_up_follow_point",
	]);
	
	super.enter(host);


func physics_update(host: Node2D, delta: float):
	super.physics_update(host, delta);
	host.velocity = Vector2.ZERO;
	var lerp_weight : float = min(1.0, host.picked_up_follow_speed*delta);
	host.z_position = lerp(host.z_position, host.picked_up_z_position, lerp_weight);
	host.position = host.position.lerp(host.picked_up_follow_point.global_position, lerp_weight);
