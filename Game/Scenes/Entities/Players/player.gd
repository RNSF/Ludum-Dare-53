class_name Player
extends Entity

@export var friction : float;
@export var normal_walking_speed : float;
@export var carry_walking_speed : float;
@export var aim_walking_speed : float;
@export var walking_acceleration : float;
@export var gravity : float;
@export var throw_strength : float;
@export var ambient_healing : float;

@onready var package_marker := $PackageMarker;
@onready var package_z_position : float = -package_marker.position.y;
@onready var package_detector := $PackageDetector;
@onready var aiming_line := $AimingLine;
@onready var health = $Health;

var walking_speed := normal_walking_speed;
var acceleration := Vector2.ZERO;
var z_acceleration := 0.0;
var picked_up_package : Package;



func _process(delta: float) -> void:
	health.heal(ambient_healing*delta);
	super._process(delta);
