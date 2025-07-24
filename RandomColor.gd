extends Label


# Called when the node enters the scene tree for the first time.
func _process(_delta):
	modulate.h += 0.00025
	if modulate.h == 359:
		modulate.h = 0
	
