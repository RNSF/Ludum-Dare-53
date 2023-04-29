class_name PlayerController
extends EntityController


func update(host: Node2D, delta: float) -> void:
	find_walking_direction();
	return super.update(host, delta);


func find_walking_direction():
	controls["Walking Direction"] = Vector2(
		Input.get_action_raw_strength("player_move_right") - Input.get_action_raw_strength("player_move_left"),
		Input.get_action_raw_strength("player_move_down") - Input.get_action_raw_strength("player_move_up")
	);
