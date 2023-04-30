extends Node2D


func play(host: Node2D):
	var parent = host.get_parent();
	var other = duplicate();
	if(is_instance_valid(parent)):
		parent.add_child(other);
		other.global_position = global_position;
		for child in other.get_children():
			if(child is CPUParticles2D):
				child.emitting = true;
			if(child is Timer):
				child.start();
	


func _on_death_timer_timeout() -> void:
	queue_free();
	pass # Replace with function body.
