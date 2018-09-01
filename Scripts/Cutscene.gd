extends Node

export (String) var nextScene

func _ready():
	$AnimationPlayer.play("C1_Anim")

func _on_AnimationPlayer_animation_finished(anim_name):
	#https://godotengine.org/qa/6491/read-&-write
	var file = File.new()
	if file.open("Cache.sav", File.WRITE) == 0:
		file.store_line(nextScene)
		file.close()
	get_tree().change_scene(nextScene)
