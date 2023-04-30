class_name Entity
extends Node2D

var velocity : Vector2;

var z_position : float;
var z_velocity : float;

@onready var character_body_2d := $CharacterBody2D;
@onready var animation_player := $AnimationPlayer;
@onready var controllers := $Controllers;
@onready var states := $States;
@onready var sprites := $Sprites;
@onready var z_offset := $Sprites/ZOffset;

func _ready():
	controllers.state_machine = states;
	controllers.setup(self);
	states.setup(self);
	pass # Replace with function body.

func _process(delta: float) -> void:
	controllers.update(self, delta);
	states.update(self, delta);

func _physics_process(delta: float) -> void:
	controllers.physics_update(self, delta);
	states.physics_update(self, delta);
	move(delta);
	z_index = global_position.y + 1000000;

func move(delta: float, slide := true):
	if(slide):
		character_body_2d.velocity = velocity;
		character_body_2d.move_and_slide();
		velocity = character_body_2d.velocity;
	else:
		var collision = character_body_2d.move_and_collide(velocity*delta);
		if(collision):
			velocity = Vector2.ZERO;
	
	position += character_body_2d.position;
	character_body_2d.position = Vector2.ZERO;
	
	z_position += z_velocity * delta;
	
	if(z_position <= 0):
		z_position = 0;
		z_velocity = 0;
	
	z_offset.position = Vector2.UP * z_position;
