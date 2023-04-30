class_name LevelWorld
extends GameWorld

signal level_completed
signal level_failed
signal level_go_back

@onready var level_end := $LevelEnd;
@onready var camera := $Camera;
@onready var player := $Entities/Player;
@onready var lost := false;
@onready var finish_timer := $FinishTimer;
@onready var game_ui := $UI/GameUI
var won := false;
var go_back := false;

func _ready() -> void:
	level_end.total_number_of_packages = count_total_number_of_packages();
	level_end.update_label();
	camera.animate("to_player", level_end.global_position, 1.0, player.global_position, 0.7, 3.0);
	player.remove_control();

func _process(delta: float) -> void:
	super._process(delta);
	if(Input.is_action_just_pressed("restart_level")):
		lost = true;
		transition.fade_out();
	if(Input.is_action_just_pressed("next_level")):
		won = true;
		transition.fade_out();
	if(Input.is_action_just_pressed("previous_level")):
		go_back = true;
		transition.fade_out();
func _on_level_end_level_completed() -> void:
	won = true;
	transition.fade_out();
	pass # Replace with function body.


func count_total_number_of_packages():
	var total := 0;
	
	for entity in entities.get_children():
		if(entity is Package):
			total += 1;
			entity.destroyed.connect(_on_package_destroyed);
	
	return total;


func _on_camera_animation_finished(anim_name) -> void:
	match anim_name:
		"to_player":
			camera.camera.enabled = false;
			remove_child(camera);
			player.add_child(camera);
			camera.position = Vector2.ZERO;
			camera.snap();
			player.give_control();
			camera.camera.enabled = true;
		"to_player_loss":
			fail();
		"to_package_loss":
			fail();
	pass # Replace with function body.


func _on_player_caught() -> void:
	if(lost):
		return
	lost = true;
	player.remove_control();
	remove_camera_from_player();
	camera.animate("to_player_loss", camera.position, camera.camera.zoom.x, player.global_position, 0.8, 0.3, Tween.EASE_OUT);
	game_ui.end_text.display("Caught!");
	pass # Replace with function body.

func _on_package_destroyed(package) -> void:
	if(lost):
		return
	lost = true;
	player.remove_control();
	remove_camera_from_player();
	camera.animate("to_package_loss", camera.position, camera.camera.zoom.x, package.global_position, 0.8, 0.3, Tween.EASE_OUT);
	game_ui.end_text.display("Package Lost!");

func remove_camera_from_player():
	camera.camera.enabled = false;
	var pos : Vector2 = camera.global_position;
	player.remove_child(camera);
	add_child(camera);
	camera.global_position = pos;
	camera.snap();
	camera.camera.enabled = true

func fail():
	finish_timer.start();

func _on_finish_timer_timeout() -> void:
	transition.fade_out();

func faded_out():
	if(go_back):
		emit_signal("level_go_back");
	if(won):
		emit_signal("level_completed");
	else:
		emit_signal("level_failed");
	pass
