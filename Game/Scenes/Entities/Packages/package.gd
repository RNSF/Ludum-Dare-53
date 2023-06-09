class_name Package
extends Entity

signal destroyed(package)

@export var gravity : float;
@export var friction : float;
@export var weight : float;
@export var min_horizontal_throwing_speed : float;
@export var max_horizontal_throwing_speed : float;

var picked_up_follow_point: Node2D;
var picked_up_follow_speed := 30.0;
var is_highlighted := false : set = set_is_hightlighted;
var acceleration := Vector2.ZERO;
var z_acceleration := 0.0;
var max_throw_distance := 0.0;
var aim_point : Vector2;
var aim_velocity : Vector3;
var throw_line_points : Array[Vector3];
var temp_collision_mask;
var temp_collision_layer;


@onready var pick_up_collider := $PickUpCollider;
@onready var light_occluder := $LightOccluder2D;
@onready var sprite_cycler := $Sprites/ZOffset/SpriteCycler;
@onready var hurt_box := $HurtBox;
@onready var health := $Health;
@onready var collection_area := $CollectionArea;
@onready var destroy_particle := $DestroyParticle;
@onready var sounds := $Sounds;

func pick_up(follow_point: Node2D) -> void:
	picked_up_follow_point = follow_point;
	states.change_state(self, "PackagePickedUpState");


func set_is_hightlighted(n: bool):
	is_highlighted = n;
	sprites.modulate = Color(0.8, 0.8, 0.8) if is_highlighted else Color.WHITE;

func aim(target_aim_point, throw_strength: float) -> void:
	max_throw_distance = throw_strength/weight;
	if(target_aim_point):
		var throw_vector = (target_aim_point - global_position) * scale.x;
		aim_point = global_position + min(throw_vector.length(), max_throw_distance) * throw_vector.normalized();
		update_aim_velocity();
		states.change_state(self, "PackageAimingState");
	else:
		states.change_state(self, "PackagePickedUpState");


func update_aim_velocity() -> void:
	var throwing_distance := (aim_point - global_position).length();
	var throwing_direction := (aim_point - global_position).normalized();
	var range_percentage := throwing_distance / (max_throw_distance);
	var horizontal_throwing_speed : float = lerp(min_horizontal_throwing_speed, max_horizontal_throwing_speed, range_percentage);
	var horizontal_throwing_velocity = throwing_direction * horizontal_throwing_speed;
	
	
	var time : float = throwing_distance / horizontal_throwing_speed;
	var z_throwing_speed = (0.5*gravity*pow(time, 2) - z_position) / (time);
	
	aim_velocity = Vector3(
		horizontal_throwing_velocity.x,
		horizontal_throwing_velocity.y,
		z_throwing_speed
	);
	
	

func throw() -> void:
	velocity = Vector2(aim_velocity.x, aim_velocity.y);
	z_velocity = aim_velocity.z; 
	states.change_state(self, "PackageThrownState");


func _on_health_damaged(health, amount) -> void:
	destroy_particle.play(self);
	for i in range(ceil(amount)):
		sprite_cycler.next();
	pass # Replace with function body.


func _on_health_died(health) -> void:
	emit_signal("destroyed", self);
	Global.camera_shake(12.0, 0.4);
	destroy_particle.play(self);
	destroy_particle.play(self, true);
	queue_free();
	pass # Replace with function body.

func collect():
	destroy_particle.play(self);
	queue_free();
