extends Node2D

@onready var line = $Line2D
@onready var cursor = $Cursor
@onready var build_sfx = $Build
@onready var place_sfx = $Place


var plankPath = preload("res://Plank.tscn")

var mouse_pos = Vector2.ZERO

var distance = float()
var min_length = 200
var max_length = 1200

var on_plank = false
var pressing = false
var dependency
var found_on_last_frame = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !pressing and !found_on_last_frame:
		cursor.global_position = get_global_mouse_position()
		if cursor.is_colliding():
			for c in cursor.get_collision_count():
				if cursor.get_collider(c) is RigidBody2D:
					on_plank = true
					break
				else:
					on_plank = false
	if on_plank and !found_on_last_frame and cursor.is_colliding():
		dependency = cursor.get_collider(0)
		found_on_last_frame = true
		return
	if Input.is_action_just_pressed("lmb") and found_on_last_frame:
		pressing = true
		build_sfx.play()
		mouse_pos = get_global_mouse_position()
		line.points[0] = get_global_mouse_position()
	if Input.is_action_pressed("lmb") and found_on_last_frame and pressing:
		line.points[1] = get_global_mouse_position()
		
		distance = mouse_pos.distance_to(get_global_mouse_position())
		if distance < min_length or distance > max_length:
			line.default_color = Color("FF00007F")
		else:
			line.default_color = Color("FFFFFF7F")
			
	if Input.is_action_just_released("lmb") and pressing:
		line.points[0] = Vector2.ZERO
		line.points[1] = Vector2.ZERO
		pressing = false
		if !found_on_last_frame and !pressing:
			return
		distance = mouse_pos.distance_to(get_global_mouse_position())
		if distance < min_length or distance > max_length:
			return
		place_sfx.play()
		var plank = plankPath.instantiate()
		plank.scale.x = distance
		plank.global_position = (mouse_pos+get_global_mouse_position())/2
		plank.look_at(mouse_pos)
		get_parent().add_child(plank)
		plank.get_child(2).global_position = mouse_pos
		plank.get_child(2).global_rotation = 0.0
		plank.get_child(2).node_a = plank.get_path()
		plank.get_child(2).node_b = dependency.get_path()
	if !pressing and found_on_last_frame:
		found_on_last_frame = false
