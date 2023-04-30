class_name Health
extends Node

signal died(health: Health)

@export var max_health : float;
@onready var health := max_health;


func heal(amount: float) -> float:
	var old_health := health;
	health += min(max_health - health, amount);
	return amount - (health - old_health);

func damage(amount: float) -> float:
	var old_health := health;
	health -= min(health, amount);
	if(health <= 0):
		die();
	return amount - (old_health - health);

func die():
	emit_signal("died", self);
