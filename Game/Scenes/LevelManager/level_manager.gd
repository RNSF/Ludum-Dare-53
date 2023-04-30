extends Node2D

const LEVEL_PATH = "res://Game/Scenes/Worlds/LevelWorlds/Levels/"

@export var level_index := 0;

var levels := [
	"level_world_7.tscn",
	"level_world_4.tscn",
	"level_world_1.tscn",
	"level_world_2.tscn",
	"level_world_3.tscn",
	
];
var current_level : LevelWorld;

func _ready() -> void:
	change_level(level_index);

func change_level(new_level_index: int) -> void:
	if(current_level):
		current_level.queue_free();
	
	level_index = new_level_index;
	
	current_level = load(LEVEL_PATH+levels[level_index % levels.size()]).instantiate();
	current_level.level_completed.connect(_on_level_completed);
	current_level.level_failed.connect(_on_level_failed);
	
	add_child(current_level);

func _on_level_completed():
	change_level(level_index + 1);

func _on_level_failed():
	change_level(level_index);
