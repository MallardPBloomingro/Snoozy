extends Node

func _ready():
	get_node("Fade").play("Fade-In")
	print("Fade in")