extends Camera2D

var start = false
var end = false
@onready var gameoverscreen = $CanvasLayer/GameOver
@onready var score = $CanvasLayer/Score
@onready var height_checker = $"../HeightChecker"
@onready var end_sfx = $End
@onready var visibilitychecker = $"../HeightChecker/VisibleOnScreenNotifier2D"
@onready var music = $Music

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !end:
		if start:
			global_position.y -= 0.5
		#if get_parent().get_child(get_parent().get_child_count()-1) is RigidBody2D:
			#global_position.y = clampf(get_parent().get_child(get_parent().get_child_count()-1).global_position.y,-INF,960)
		if Input.is_action_just_released("lmb"):
			if !music.playing:
				music.play()
			start = true
			score.visible = true
		if -int((height_checker.score-1760)/10) != 0:
			score.text = str(-int((height_checker.score-1760)/100))
	else:
		if Input.is_action_just_released("lmb"):
			get_tree().paused = false
			get_tree().change_scene_to_file("res://Main.tscn")

#func _on_end_body_entered(body: Node2D) -> void:
	#if body is RigidBody2D:
		#get_tree().paused = true
		#end = true
		#end_sfx.play()
		#gameoverscreen.visible = true
		#global_position = body.global_position
		#var target_zoom = 1/(body.global_position.distance_to(Vector2(540,960))/300)
		#zoom = Vector2(target_zoom,target_zoom)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if visibilitychecker.global_position.y > global_position.y:
		music.stop()
		end = true
		end_sfx.play()
		gameoverscreen.visible = true
		var target_zoom = 1/(global_position.distance_to(Vector2(540,1200))/300)
		zoom = Vector2(target_zoom,target_zoom)
