class_name PlayerController
extends EntityController


func update(host: Node2D, delta: float):
	find_walking_direction(host);
	controls["Pick Up"] = Input.is_action_just_pressed("player_pick_up");
	find_aim_point(host);
	controls["Throw"] = Input.is_action_just_released("player_aim");
	return super.update(host, delta);


"""
func find_walking_direction():
	controls["Walking Direction"] = Vector2(
		Input.get_action_raw_strength("player_move_right") - Input.get_action_raw_strength("player_move_left"),
		Input.get_action_raw_strength("player_move_down") - Input.get_action_raw_strength("player_move_up")
	).normalized();
"""

func find_walking_direction(host: Node2D):
	controls["Walking Direction"] = (host.get_global_mouse_position() - host.global_position).normalized() * Input.get_action_raw_strength("player_move");

func find_aim_point(host: Node2D):
	controls["Start Aim"] = Input.is_action_just_pressed("player_aim");
	controls["Aim Point"] = host.get_global_mouse_position() if Input.is_action_pressed("player_aim") else null;
