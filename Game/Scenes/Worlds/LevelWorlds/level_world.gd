class_name LevelWorld
extends GameWorld

signal level_completed

@onready var level_end := $LevelEnd;
@onready var camera := $Camera;
@onready var player := $Entities/Player;

func _ready() -> void:
	level_end.total_number_of_packages = count_total_number_of_packages();
	level_end.update_label();
	camera.animate("to_player", level_end.global_position, 1.0, player.global_position, 0.8, 3.0);
	player.remove_control();

func _on_level_end_level_completed() -> void:
	emit_signal("level_completed");
	pass # Replace with function body.


func count_total_number_of_packages():
	var total := 0;
	
	for entity in entities.get_children():
		if(entity is Package):
			total += 1;
	
	return total;


func _on_camera_animation_finished(anim_name) -> void:
	match anim_name:
		"to_player":
			remove_child(camera);
			player.add_child(camera);
			player.give_control();
	pass # Replace with function body.
