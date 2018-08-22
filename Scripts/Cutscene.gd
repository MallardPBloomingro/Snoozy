extends Node

export (String) var nextScene


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene(nextScene)
