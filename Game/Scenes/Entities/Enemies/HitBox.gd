extends Area2D


@export var damage := 10.0;

func _on_area_entered(area: Area2D) -> void:
	if(!(area is HurtBox)):
		return
	
	area.damage(damage);
