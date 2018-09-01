extends Area2D

export (NodePath) var playerPosition
export (int, 0, 5) var distToAlarmClock#mit range für unterstütze entfernungen

func _ready():
	#signal connecten, damit das nicht der Game Designer machen muss
	connect("area_entered", self,"_on_ActiveZone_area_entered")
	connect("area_exited", self, "_on_ActiveZone_area_exited")
	$OpeningAnimation.stop()
	set_meta("Type", "Door")#damit für den spieler ersichtlich ist was ne tür ist auch wenn die node nicht "Door" heist
	#audio dampening anhand der entfernung einstellen
	if distToAlarmClock == 0:
		pass
	elif distToAlarmClock == 1:
		$Audio.bus = "Dist1"
	elif distToAlarmClock == 2:
		$Audio.bus = "Dist2"
	elif distToAlarmClock == 3:
		$Audio.bus = "Dist3"
	elif distToAlarmClock == 4:
		$Audio.bus = "Dist4"
	elif distToAlarmClock == 5:
		$Audio.bus = "Dist5"
	else:
		$Audio.bus = "Dist5"

func traverse():
	$OpeningAnimation.play()
	get_parent().get_node("Fade").play("Fade-Out")
	$Timer.start()

func _on_Timer_timeout():
	get_parent().get_node("Player").start(get_node(playerPosition).position) #man übergiebt die tür zu der es gehen soll und diese formel ziet sich dich position raus und übergiebt die dem player
	get_parent().get_node("Fade").play("Fade-In")
	$OpeningAnimation.stop()
	$OpeningAnimation.frame = 0

func _on_ActiveZone_area_entered(area):
	if area.name == "ActiveZone" && distToAlarmClock > 0:
		$Audio.play()

func _on_ActiveZone_area_exited(area):
	if area.name == "ActiveZone":
		$Audio.stop()