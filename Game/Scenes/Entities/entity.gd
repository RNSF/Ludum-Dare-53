extends Node2D

@onready var character_body_2d := $CharacterBody2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	position += character_body_2d.position;
	character_body_2d.position = Vector2.ZERO;
