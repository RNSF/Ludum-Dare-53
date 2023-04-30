class_name GameWorld
extends Node2D


@onready var ground := $Ground;
@onready var walls := $Walls;
@onready var entities := $Entities;
@onready var transition := $UI/Transition;

func _process(delta: float) -> void:
	pass

func _on_transition_faded_out() -> void:
	faded_out();
	pass # Replace with function body.

func faded_out():
	pass
