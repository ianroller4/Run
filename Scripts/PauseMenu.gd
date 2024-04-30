extends CanvasLayer

@onready var RESUME := $Menu/Resume
@onready var QUIT := $Menu/Quit

func _on_menu_chosen(item):
	match item:
		RESUME:
			Global.paused = false
			self.hide()
		QUIT:
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
