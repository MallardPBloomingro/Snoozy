extends Area2D



export (int) var height
export (String) var nextScene
export (int) var playerPosition

func _ready():
	$OpeningAnimation.stop()

func traverse():
	$OpeningAnimation.play()
	get_parent().get_parent().get_parent().get_node("Fade").play("Fade-Out")
	$Timer.start()



func _on_Timer_timeout():
	var root = get_parent().get_parent()
	root.get_parent().get_node("Player").start(playerPosition)
	root.add_child(load(nextScene).instance())#TODO: change scene nodes
	var level = get_parent()
	root.remove_child(level)
	level.call_deferred("free")
	pass # replace with function body
