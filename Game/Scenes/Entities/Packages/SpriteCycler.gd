extends Node2D

@export var index := 0 : set = set_index;


func _ready() -> void:
	set_index(index);

func next():
	set_index(index+1);


func set_index(n: int):
	get_child(index).hide();
	index = clamp(n, 0, get_child_count() - 1);
	get_child(index).show();
