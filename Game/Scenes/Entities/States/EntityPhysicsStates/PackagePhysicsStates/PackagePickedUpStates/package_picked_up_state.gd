class_name PackagePickedUpState
extends PackagePhysicsState

var temp_collision_mask;
var temp_collision_layer;

func enter(host: Node2D) -> void:
	required_host_variables.append_array([
		"picked_up_follow_speed",
		"picked_up_follow_point",
		"temp_collision_mask",
		"temp_collision_layer",
		"light_occluder"
	]);
	
	host.light_occluder.hide();
	
	host.temp_collision_mask = host.character_body_2d.collision_mask;
	host.temp_collision_layer = host.character_body_2d.collision_layer;
	
	host.character_body_2d.collision_mask = 0
	host.character_body_2d.collision_layer = 0;
	
	super.enter(host);


func physics_update(host: Node2D, delta: float):
	super.physics_update(host, delta);
	host.velocity = Vector2.ZERO;
	host.z_velocity = 0;
	var lerp_weight : float = min(1.0, host.picked_up_follow_speed*delta);
	host.z_position = lerp(host.z_position, host.picked_up_follow_point.z_position, lerp_weight);
	host.position = host.position.lerp(host.picked_up_follow_point.point, lerp_weight);

func exit(host: Node2D) -> void:
	host.character_body_2d.collision_mask = host.temp_collision_mask;
	host.character_body_2d.collision_layer = host.temp_collision_layer;
