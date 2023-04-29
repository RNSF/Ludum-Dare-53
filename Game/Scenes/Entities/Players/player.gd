extends Entity

@export var friction : float;
@export var normal_walking_speed : float;
@export var carry_walking_speed : float;
@export var walking_acceleration : float;
@export var gravity : float;

var walking_speed := normal_walking_speed;
var acceleration := Vector2.ZERO;
var z_acceleration := 0.0;
