extends Area2D

@export var maximum_pick_up_distance: float;

var highlighted_package : Package = null : set = set_highlighted_package;


	
	

func _physics_process(delta: float) -> void:
	var closest_package := find_closest_package_to_mouse();
	set_highlighted_package(closest_package);
	

func find_closest_package_to_mouse() -> Package:
	var closest_package : Package;
	var closest_package_distance : float = maximum_pick_up_distance;
	
	for area in get_overlapping_areas():
		var package := area.get_parent();
		if(!is_instance_valid(package) or !(package is Package)):
			continue
		
		var distance : float = area.global_position.distance_to(get_global_mouse_position());
		
		if(distance < closest_package_distance):
			closest_package = package;
			closest_package_distance = distance;
	
	return closest_package;

func set_highlighted_package(n: Package) -> void:
	if(highlighted_package != n):
		if(highlighted_package != null):
			highlighted_package.is_highlighted = false;
		highlighted_package = n;
		if(highlighted_package != null):
			highlighted_package.is_highlighted = true;
