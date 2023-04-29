class_name Entity
extends Node2D



@onready var character_body_2d := $CharacterBody2D;
@onready var animation_player := $AnimationPlayer;
@onready var controllers := $Controllers;
@onready var states := $States;

var velocity : Vector2;


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
	move();

func move():
	character_body_2d.velocity = velocity;
	character_body_2d.move_and_slide();
	velocity = character_body_2d.velocity;
	position += character_body_2d.position;
	character_body_2d.position = Vector2.ZERO;
