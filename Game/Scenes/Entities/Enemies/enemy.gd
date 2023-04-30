class_name Enemy
extends Entity



@export var walk_speed := 400.0;
@export var ping_pong := false;
@export var start_reverse := false;
var go_reverse := false : set = set_go_reverse;

@onready var path_follow := $Path2D/PathFollow2D;
@onready var path := $Path2D;
@onready var player_detector := $PlayerDetector;

var switch_frame_ticker := 1;
var override_ticker = true;

func _ready() -> void:
	super._ready();
	set_go_reverse(start_reverse);
	override_ticker = false;
	path_follow.loop = !ping_pong;

func _process(delta: float) -> void:
	super._process(delta);
	sprites.scale.x = int(!(player_detector.angle > PI/2 - 0.01 and player_detector.angle < 3*PI/2 + 0.01 ))*2 - 1

func _physics_process(delta: float) -> void:
	super._physics_process(delta);
	switch_frame_ticker -= 1;

func set_go_reverse(n: bool):
	if(switch_frame_ticker <= 0 or override_ticker):
		go_reverse = n;
		player_detector.go_reverse = go_reverse;
		walk_speed = - abs(walk_speed) * (int(go_reverse)*2-1);
		switch_frame_ticker = 3;
