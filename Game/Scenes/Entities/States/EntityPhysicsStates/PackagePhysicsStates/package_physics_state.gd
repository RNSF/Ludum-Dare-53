class_name PackagePhysicsState
extends EntityPhysicsState


func enter(host: Node2D) -> void:
	required_host_variables.append_array([
		"pick_up_collider",
	]);
	
	super.enter(host);
