extends EntityPathState


func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"player_detector"
	]);

func update(host: Node2D, delta: float):
	host.player_detector.target_angle = host.velocity.angle();
	return super.update(host, delta);
	
