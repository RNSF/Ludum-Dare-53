class_name PackageThrownState
extends PackagePhysicsState


func enter(host: Node2D) -> void:
	super.enter(host);
	host.pick_up_collider.monitorable = false;

func physics_update(host: Node2D, delta: float):
	if(host.z_position <= 0):
		return "PackageLandedState";
	return super.physics_update(host, delta);
