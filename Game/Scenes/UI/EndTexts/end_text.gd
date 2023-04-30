extends Label

@onready var animation_player := $AnimationPlayer;

func _ready() -> void:
	hide();

func display(message: String) -> void:
	text = message;
	show();
	animation_player.play("show");


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"show":
			animation_player.play("move");
	pass # Replace with function body.
