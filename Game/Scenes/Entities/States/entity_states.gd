class_name EntityStates
extends StateMachine

func update_controls(controls) -> void:
	for child in get_children():
		child.controls = controls;


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	for child in get_children():
		child._on_animation_finished(anim_name);
