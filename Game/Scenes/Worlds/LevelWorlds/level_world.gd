class_name LevelWorld
extends GameWorld


@onready var level_end := $LevelEnd;

func _ready() -> void:
	level_end.total_number_of_packages = count_total_number_of_packages();
	level_end.update_label();

func _on_level_end_level_completed() -> void:
	next_level();
	pass # Replace with function body.

func next_level():
	pass

func count_total_number_of_packages():
	var total := 0;
	
	for entity in entities.get_children():
		if(entity is Package):
			total += 1;
	
	return total;
