extends CanvasLayer

@onready var BACK := $Menu/Back

func _on_menu_chosen(item):
	match item:
		BACK:
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
