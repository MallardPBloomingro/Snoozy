extends Node

export (String) var nextScene

func _ready():
	$AnimationPlayer.play("C1_Anim")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene(nextScene)
