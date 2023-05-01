class_name PackageLandedState
extends PackagePhysicsState


func enter(host: Node2D) -> void:
	super.enter(host);
	host.pick_up_collider.monitorable = true;
	host.velocity = Vector2.ZERO;
	host.light_occluder.show();
	host.collection_area.in_simulation_mode = false;
	host.hurt_box.monitorable = true;
	host.sounds.play("Land");
	Global.camera_shake(5.0, 0.2);

func exit(host: Node2D) -> void:
	host.hurt_box.monitorable = false;
	Global.camera_shake(1.0, 0.15);
	host.sounds.play("PickUp");
	super.exit(host);
