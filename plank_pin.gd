extends PinJoint2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	global_scale = Vector2(2,2)
	if get_parent().rotation_degrees > 92 or get_parent().rotation_degrees < 88:
		angular_limit_lower = -15
		angular_limit_upper = 15
	else:
		angular_limit_lower = 0
		angular_limit_upper = 0
