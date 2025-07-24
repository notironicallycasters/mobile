extends Sprite2D

var uv_rect
var uv_scale

var pixel_scale = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	uv_rect = (global_scale.x/0.017)*pixel_scale
	uv_scale = (region_rect.size.x/pixel_scale)*0.017
	region_rect.size.x = uv_rect
	scale.x = uv_scale
	
