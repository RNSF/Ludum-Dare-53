class_name HurtBox
extends Area2D

@export var health: Health;

func damage(amount: float) -> float:
	return health.damage(amount);
