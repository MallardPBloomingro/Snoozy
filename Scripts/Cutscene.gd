extends Node

export (String) var nextScene
export (int) var playerPosition


func _on_AnimationPlayer_animation_finished(anim_name):
	var root = get_parent()
	root.get_parent().get_node("Player").show()
	root.get_parent().get_node("Player").start(playerPosition)
	root.add_child(load(nextScene).instance())#TODO: change scene nodes
	var level = get_parent()
	root.remove_child(level)
	level.call_deferred("free")
