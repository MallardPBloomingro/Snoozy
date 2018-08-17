extends Area2D


export (int) var speed
export (int) var height = 0
export (int) var collisionDist

var target = 0
var isWalking = false

func start (var x, var setActiveCamera = true):
	position.x = x
	target = x
	$Camera2D.position.x = x
	position.y = height
	pass

func _process(delta):
	var dir = 0
	if Input.is_mouse_button_pressed(1):
		target = get_global_mouse_position().x
	
	collisionObstacle()
	
	if abs(position.x-target) < speed * delta:
		if isWalking:
			collisionHandler()
		isWalking = false
		position.x = target
	elif position.x < target:
		isWalking = true
		position.x += speed * delta
		$WalkingAnimation.flip_h = false
	else:
		isWalking = true
		position.x -= speed * delta
		$WalkingAnimation.flip_h = true
	
	if position.x != target:
		$WalkingAnimation.play()
	else:
		$WalkingAnimation.stop()
	
func collisionHandler():# Am I in door or alarm?
	var col = get_overlapping_areas()
	if !col.empty():
		if col[0].name == "Door":
			col[0].traverse()
			pass # TODO: send signal and play opening animation
		elif col[0].name == "AlarmClock":
			get_parent().get_node("Fade").play("Fade-Out")
			$Timer.start()
			pass # TODO: send signal and play alarm shut down animation
	else:
		pass # TODO: play idle animation

func collisionObstacle():
	var col = get_overlapping_areas()
	if col.empty():
		return
	if col[0].name == "Door" || col[0].name == "AlarmClock":
		return
	
	if col[0].position.x < position.x:
		position.x = col[0].position.x + collisionDist
	else:
		position.x = col[0].position.x - collisionDist
	
	target = position.x
	print(col[0].name)

func _on_Timer_timeout():
	var root = get_parent().get_child("Level")
	hide()
	#root.get_parent().get_node("Player").start(playerPosition)
	root.get_child(0).queue_free()
	root.add_child(load(nextScene).instance())#TODO: change scene nodes
	var level = get_parent()
	root.remove_child(level)
	level.call_deferred("free")
