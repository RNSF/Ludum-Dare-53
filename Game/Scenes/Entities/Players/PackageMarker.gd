extends Marker2D


@export var player: Player;
var z_position;
var point;

func _process(delta: float) -> void:
	if(player):
		z_position = - global_position.y + player.global_position.y
		point = Vector2(global_position.x, player.global_position.y);
