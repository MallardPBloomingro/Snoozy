extends Area2D

export (NodePath) var playerPosition

func _ready():
	$OpeningAnimation.stop()

func traverse():
	$OpeningAnimation.play()
	get_parent().get_node("Fade").play("Fade-Out")
	$Timer.start()

func _on_Timer_timeout():
	get_parent().get_node("Player").start(get_node(playerPosition).position) #man übergiebt die tür zu der es gehen soll und diese formel ziet sich dich position raus und übergiebt die dem player
	get_parent().get_node("Fade").play("Fade-In")
