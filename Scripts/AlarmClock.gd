extends Area2D

export (String) var nextScene

func _ready():
	connect("area_entered", self,"_on_ActiveZone_area_entered")
	connect("area_exited", self, "_on_ActiveZone_area_exited")

func press():
	get_parent().get_node("Fade").play("Fade-Out")
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene(nextScene)


func _on_ActiveZone_area_entered(area):
	if area.name == "ActiveZone":
		$Audio.play()


func _on_ActiveZone_area_exited(area):
	if area.name == "ActiveZone":
		$Audio.stop()
