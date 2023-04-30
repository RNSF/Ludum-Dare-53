extends Node2D

signal level_completed

var collected_packages := 0;
var total_number_of_packages := 0;

@onready var animation_player := $AnimationPlayer;
@onready var label := $Sprites/Label;


func collect(package: Package) -> void:	
	package.collect();
	animation_player.play("collect");
	collected_packages += 1;
	
	if(collected_packages >= total_number_of_packages):
		emit_signal("level_completed");
	
	update_label();
	
	pass # Replace with function body.

func update_label():
	label.text = str(collected_packages) + "/" + str(total_number_of_packages);

func highlight():
	animation_player.play("reachable");

func unhighlight():
	animation_player.play("normal");
