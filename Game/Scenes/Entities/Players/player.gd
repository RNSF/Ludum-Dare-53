extends Entity

@export var friction : float;
@export var normal_walking_speed : float;
@export var slow_walking_speed : float;
@export var walking_acceleration : float;

var walking_speed : float;

var acceleration := Vector2.ZERO;
