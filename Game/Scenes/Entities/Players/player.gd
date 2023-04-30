class_name Player
extends Entity

signal caught

@export var friction : float;
@export var normal_walking_speed : float;
@export var carry_walking_speed : float;
@export var aim_walking_speed : float;
@export var walking_acceleration : float;
@export var gravity : float;
@export var throw_strength : float;
@export var ambient_healing : float;

@onready var package_marker := $Sprites/ZOffset/Hands/PackageMarker;
@onready var package_z_position : float = -package_marker.position.y;
@onready var package_detector := $PackageDetector;
@onready var aiming_line := $AimingLine;
@onready var health = $Health;
@onready var watcher_points := $WatcherPoints;

var walking_speed := normal_walking_speed;
var acceleration := Vector2.ZERO;
var z_acceleration := 0.0;
var picked_up_package : Package;
var prev_animation := "";



func _process(delta: float) -> void:
	health.heal(ambient_healing*delta);
	var dir := get_global_mouse_position() - global_position;
	sprites.scale.x = -sign(dir.x) if sign(dir.x) != 0 else sprites.scale.x;
	super._process(delta);


func _on_health_died(health) -> void:
	Global.camera_shake(12.0, 0.4);
	emit_signal("caught");
	pass # Replace with function body.

func give_control():
	controllers.change_state(self, "PlayerController");

func remove_control():
	controllers.change_state(self, "ClearedController");
