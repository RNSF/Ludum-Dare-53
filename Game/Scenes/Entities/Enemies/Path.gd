extends Path2D


@onready var line := $Line2D;
@onready var line_shadow := $ShadowLine;

func _ready() -> void:
	line.points = curve.get_baked_points();
	line_shadow.points = curve.get_baked_points();
	pass # Replace with function body.

func _process(delta: float) -> void:
	global_position = Vector2.ZERO;
