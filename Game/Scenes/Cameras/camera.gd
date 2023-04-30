extends Node2D

signal animation_finished(anim_name: String);

var is_animating := false;
var current_animation_name : String;

@onready var camera := $Camera2D;

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
