extends Node

export (String) var firstScene


func _on_Continue_pressed():
	var file = File.new()
	if file.file_exists("Cache.sav"):
		if file.open("Cache.sav", File.READ) == 0:
			get_tree().change_scene(file.get_line())
			return
	_on_Restart_pressed()#falls noch nie gespeichert wurde


func _on_Restart_pressed():
	#https://godotengine.org/qa/6491/read-&-write
	var file = File.new()
	if file.open("Cache.sav", File.WRITE) == 0:
		file.store_line(firstScene)
		file.close()
	get_tree().change_scene(firstScene)


func _on_Exit_pressed():
	get_tree().quit()
