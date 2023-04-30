class_name Enemy
extends Entity



@export var walk_speed := 400.0;

@onready var path_follow := $Path2D/PathFollow2D;
@onready var path := $Path2D;
@onready var player_detector := $PlayerDetector;
