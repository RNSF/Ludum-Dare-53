class_name State
extends Node

@export var track_old := false;
var required_host_variables := [];

func enter(host: Node2D) -> void:
	for required_host_variable in required_host_variables:
		if(not required_host_variable in host):
			print("STATE ERROR: Host object does not have ' " + required_host_variable + " ' variable!");
	return

func exit(_host: Node2D) -> void:
	return

func update(_host: Node2D, _delta: float):
	return

func physics_update(_host: Node2D, _delta: float):
	return

func _on_animation_finished(_anim_name: String) -> void:
	return
