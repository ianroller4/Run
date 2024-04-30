extends Control

@onready var PLAY := $Menu/Play
@onready var BACK := $Menu/Back
@onready var QUIT := $Menu/Quit

@onready var MENU := $Menu as Menu

@onready var one := $Scores/First as Label
@onready var two := $Scores/Second as Label
@onready var three := $Scores/Third as Label
@onready var four := $Scores/Fourth as Label
@onready var fifth := $Scores/Fifth as Label

func _ready():
	MENU.ConfigFocus()
	one.text = str(HighScore.First)
	two.text = str(HighScore.Second)
	three.text = str(HighScore.Third)
	four.text = str(HighScore.Fourth)
	fifth.text = str(HighScore.Fifth)

func _on_menu_chosen(item):
	match item:
		PLAY:
			get_tree().change_scene_to_file("res://Scenes/Game.tscn")
		BACK:
			get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
		QUIT:
			get_tree().quit()
