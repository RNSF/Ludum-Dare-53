extends Node


func play(sound_name: String) -> void:
	var sound := get_node(sound_name);
	if(sound):
		if(!sound.playing):
			sound.play();

func stop(sound_name: String) -> void:
	var sound := get_node(sound_name);
	if(sound):
		sound.stop();
