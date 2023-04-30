extends EntityPathState


func enter(host: Node2D) -> void:
	super.enter(host);
	required_host_variables.append_array([
		"player_detector"
	]);

func update(host: Node2D, delta: float):
	host.player_detector.target_angle = host.velocity.angle();
	return super.update(host, delta);
	
func physics_update(host: Node2D, delta: float):
	if(host.character_body_2d.get_slide_collision_count() > 0):
		
		host.go_reverse = !host.go_reverse;
	
	return super.physics_update(host, delta);
