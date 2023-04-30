extends Area2D

var will_be_in := false;
var in_simulation_mode := false;
var real_pos := Vector2.ZERO;
var level_end;

func _on_area_entered(area: Area2D) -> void:
	will_be_in = true;
	if(in_simulation_mode):
		level_end = area.get_parent();
		if(is_instance_valid(level_end)):
			level_end.highlight();
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	will_be_in = false;
	if(in_simulation_mode):
		level_end = area.get_parent();
		if(is_instance_valid(level_end)):
			level_end.unhighlight();
	pass # Replace with function body.

func _process(delta: float) -> void:
	global_position = real_pos;
