extends Node

func _ready():
	get_parent().get_parent().get_node("Fade").play("Fade-In")

