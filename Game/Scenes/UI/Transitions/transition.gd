extends ColorRect

signal faded_out

@onready var animation_player := $AnimationPlayer;

func _ready() -> void:
	animation_player.play("fade_in");

func fade_out():
	animation_player.play("fade_out");


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name == "fade_out"):
		emit_signal("faded_out");
	pass # Replace with function body.
