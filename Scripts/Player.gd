extends Area2D


export (int) var speed
export (int) var collisionDist#TODO: müssen wir warscheinlich endern, sodass es egal ist wie breit die collisionbox ist

var target = 0
var isWalking = false

func start (var pos, var setActiveCamera = true):
	position = pos
	target = pos.x
	$Camera2D.position = pos

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
	if col.empty():
		#TODO: Idle animation
		return
	if col[0].name == "Door":
		col[0].traverse()# TODO: send signal and play opening animation
	elif col[0].name == "AlarmClock":
		col[0].press()# TODO: send signal and play alarm shut down animation

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
