extends Button



func _on_Button_pressed():
	$"/root/GlobalVars"._ready()
	var _sc = get_tree().change_scene("res://Main.tscn")
