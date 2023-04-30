extends Area2D

const STANDARD_DISTANCE := 250.0;
enum FOV {NARROW, NORMAL, FULL} 

@export var fov : FOV;
@export var distance := STANDARD_DISTANCE;
@export var fov_textures : Dictionary;

var fov_angle = 0.0;

@onready var point_light := $PointLight2D;
@onready var ray_cast := $RayCast2D;
@onready var collision_shape := $CollisionShape2D;

func _ready() -> void:
	configure_fov();
	configure_distance();

func configure_fov():
	point_light.texture = fov_textures[fov];
	fov_angle = {
		FOV.NARROW: 30,
		FOV.NORMAL: 60,
		FOV.FULL: 180,
	}.get(fov);

func configure_distance():
	point_light.scale = Vector2.ONE * distance/STANDARD_DISTANCE;
	collision_shape.shape.radius = distance;

func _physics_process(delta: float) -> void:
	for area in get_overlapping_areas():
		
		var player := area.get_parent();
		
		if(!is_instance_valid(player) or !(player is Player)):
			continue
			
		ray_cast.target_position = area.global_position - global_position;
		ray_cast.force_raycast_update();
		if(!ray_cast.is_colliding()):
			player.health.damage(delta);
