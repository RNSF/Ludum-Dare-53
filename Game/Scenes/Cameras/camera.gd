extends Node2D

signal animation_finished(anim_name: String);

@export var shake_noise : FastNoiseLite;

var is_animating := false;
var current_animation_name : String;
var shake_power := 0.0;
var shake_time := 0.0;
var total_time := 0.0;

@onready var camera := $Camera2D;

func _ready() -> void:
	Global.current_camera = self;

func _process(delta: float) -> void:
	shake_time -= delta;
	total_time += delta;
	if(shake_time <= 0):
		shake_power = 0;
		camera.offset = Vector2.ZERO;
	else:
		camera.offset = Vector2(
			shake_noise.get_noise_2d(int(total_time*50), 100),
			shake_noise.get_noise_2d(100, int(total_time*50))
		) * shake_power * 10;
		

func animate(anim_name: String, start_point: Vector2, start_zoom: float, end_point: Vector2, end_zoom: float, duration: float, ease := Tween.EASE_IN_OUT):
	is_animating = true;
	current_animation_name = anim_name;
	camera.position_smoothing_enabled = false;
	
	global_position = start_point;
	camera.zoom = Vector2.ONE * start_zoom;
	
	var tween = create_tween()
	tween.set_parallel(true);
	tween.set_ease(ease);
	tween.set_trans(Tween.TRANS_QUAD);
	tween.tween_property(self, "global_position", end_point, duration);
	tween.tween_property(camera, "zoom", Vector2.ONE*end_zoom, duration);
	
	tween.finished.connect(_on_tween_finished);

func _on_tween_finished():
	if(is_animating):
		is_animating = false;
		camera.position_smoothing_enabled = true;
		emit_signal("animation_finished", current_animation_name);

func snap():
	camera.reset_smoothing();

func shake(power: float, time: float):
	if(power >= shake_power):
		shake_power = power;
		if(time >= shake_time):
			shake_time = time;
