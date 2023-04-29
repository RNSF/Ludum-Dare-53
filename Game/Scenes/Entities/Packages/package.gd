class_name Package
extends Entity


var picked_up_follow_point: Node2D;
var picked_up_z_position: float;
var picked_up_follow_speed := 30.0;
var is_highlighted := false : set = set_is_hightlighted;

func pick_up(follow_point: Node2D, follow_z_position: float) -> void:
	picked_up_follow_point = follow_point;
	picked_up_z_position = follow_z_position;
	states.change_state("PackagePickedUpState");


func set_is_hightlighted(n: bool):
	is_highlighted = n;
	sprites.modulate = Color(0.8, 0.8, 0.8) if is_highlighted else Color.WHITE;
