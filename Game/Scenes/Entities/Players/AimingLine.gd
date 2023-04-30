extends Line2D

var points_3D : Array[Vector3] = [] : set = set_points_3D;


func set_points_3D(n: Array[Vector3]):
	global_position = Vector2.ZERO;
	points_3D = n;
	clear_points();
	for point_3D in points_3D:
		add_point(Vector2(point_3D.x, point_3D.y - point_3D.z));
