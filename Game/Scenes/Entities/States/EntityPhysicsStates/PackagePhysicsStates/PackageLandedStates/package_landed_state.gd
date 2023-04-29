class_name PackageLandedState
extends PackagePhysicsState


func enter(host: Node2D) -> void:
	super.enter(host);
	host.pick_up_collider.monitorable = true;
