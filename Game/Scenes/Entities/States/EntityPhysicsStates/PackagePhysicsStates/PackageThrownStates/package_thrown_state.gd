class_name PackageThrownState
extends PackagePhysicsState

var temp_collision_mask;

func enter(host: Node2D) -> void:
	super.enter(host);
	
	required_host_variables.append_array([
		"temp_collision_mask",
		"collection_area",
	]);
	
	host.pick_up_collider.monitorable = false;
	
	host.temp_collision_mask = host.character_body_2d.collision_layer;
	host.character_body_2d.collision_layer = 0

func physics_update(host: Node2D, delta: float):
	if(host.z_position <= 0):
		if(is_instance_valid(host.collection_area.level_end) and host.collection_area.will_be_in):
			host.collection_area.level_end.collect(host);
		else:
			host.health.damage(1);
		return "PackageLandedState";
	return super.physics_update(host, delta);

func exit(host: Node2D) -> void:
	host.character_body_2d.collision_layer = host.temp_collision_layer;
