extends Area2D

var highlighted_package : Package = null : set = set_highlighted_package;
var in_range_packages : Array[Package] = [];


func _on_area_entered(area: Area2D) -> void:
	
	
	
	in_range_packages.append(area.get_parent());


func _on_area_exited(area: Area2D) -> void:
	var package := area.get_parent();
	
	
	
	in_range_packages.erase(area.get_parent());

func _physics_process(delta: float) -> void:
	var closest_package := find_closest_package_to_mouse();
	
	

func find_closest_package_to_mouse() -> Package:
	var closest_package : Package;
	var closest_package_distance : float = INF;
	
	for package in in_range_packages:
		if(!is_instance_valid(package) or !(package is Package)):
			continue
		
		var distance : float = package.position.distance_to(get_global_mouse_position());
		
		if(package.position.distance_to(get_global_mouse_position()) < closest_package_distance):
			closest_package = package;
			closest_package_distance = distance;
	
	return closest_package;

func set_highlighted_package(n: Package) -> void:
	if(highlighted_package != n):
		highlighted_package.is_highlighted = false;
		highlighted_package = n;
		highlighted_package.is_highlighted = true;
		
