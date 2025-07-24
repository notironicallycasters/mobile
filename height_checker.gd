extends ShapeCast2D


@onready var up = true

var start = false
var score = 1760
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("lmb"):
		start = true
	if score > global_position.y and start:
		score = global_position.y
	if is_colliding():
		while is_colliding():
			global_position.y -= 1
			await get_tree().process_frame
	else:
		while !is_colliding():
			global_position.y += 1
			await get_tree().process_frame
