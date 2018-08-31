extends Area2D

export (String) var nextScene

func press():
	get_parent().get_node("Fade").play("Fade-Out")
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene(nextScene)
