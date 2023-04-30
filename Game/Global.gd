extends Node

var current_camera;

func camera_shake(power: float, time: float):
	if(current_camera):
		current_camera.shake(power, time);
