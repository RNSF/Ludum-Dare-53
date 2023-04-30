extends Area2D

const STANDARD_DISTANCE := 250.0;
enum FOV {NARROW, NORMAL, FULL} 

@export var fov : FOV;
@export var distance := STANDARD_DISTANCE;
@export var fov_textures : Dictionary;
@export var turn_speed := 3.0;
@export var offset_angle := 0.0;

var fov_angle = 0.0;
var angle := 0.0 : set = set_angle;
var target_angle := 0.0;
var go_reverse := false;

@onready var point_light := $PointLight2D;
@onready var ray_cast := $RayCast2D;
@onready var collision_shape := $CollisionShape2D;

func _ready() -> void:
	configure_fov();
	configure_distance();

func configure_fov():
	point_light.texture = fov_textures[fov];
	fov_angle = {
		FOV.NARROW: PI/6.0,
		FOV.NORMAL: PI/3.0,
		FOV.FULL: PI,
	}.get(fov);

func configure_distance():
	point_light.scale = Vector2.ONE * distance/STANDARD_DISTANCE;
	collision_shape.shape.radius = distance;

func _process(delta: float) -> void:
	var real_target_angle = target_angle + offset_angle + int(go_reverse) * PI;
	var reverse_direction : bool = abs(real_target_angle - angle) > PI;
	var modded_target_angle = real_target_angle;
	
	if(reverse_direction):
		if(target_angle > angle):
			modded_target_angle = real_target_angle - 2*PI;
		else:
			modded_target_angle = real_target_angle + 2*PI;
	
	angle = lerp(angle, modded_target_angle, turn_speed*delta);
	angle = fposmod(angle, 2*PI);

func _physics_process(delta: float) -> void:
	for area in get_overlapping_areas():
		
		var player := area.get_parent();
		
		if(!is_instance_valid(player) or !(player is Player)):
			continue
		
		for watcher_point in player.watcher_points.get_children():
			ray_cast.target_position = watcher_point.global_position - global_position;
			
			var direction = Vector2.from_angle(angle);
			
			if(abs(ray_cast.target_position.angle_to(direction)) > fov_angle):
				continue
			
			ray_cast.force_raycast_update();
			
			if(ray_cast.is_colliding()):
				continue
			
			player.health.damage(delta);
			break;

func set_angle(n: float):
	angle = n;
	point_light.rotation = angle;
	collision_shape.rotation = angle;
	
