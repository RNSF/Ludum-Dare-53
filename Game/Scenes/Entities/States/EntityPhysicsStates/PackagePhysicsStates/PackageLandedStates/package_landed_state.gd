class_name PackageLandedState
extends PackagePhysicsState


func enter(host: Node2D) -> void:
	super.enter(host);
	host.pick_up_collider.monitorable = true;
	host.velocity = Vector2.ZERO;
	host.light_occluder.show();
	host.collection_area.in_simulation_mode = false;
