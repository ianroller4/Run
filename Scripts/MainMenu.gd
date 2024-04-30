extends Control

@onready var PLAY := $Menu/Play
@onready var HS := $"Menu/High Scores"
@onready var OPTIONS := $Menu/Options
@onready var QUIT := $Menu/Quit

var savePath = "user://saveGame.save"
var saveData = {"top": 0, "two": 0, "three": 0, "four": 0, "five": 0}

func _ready():
	if not FileAccess.file_exists(savePath):
		CreateSave()
	else:
		LoadSave()

func CreateSave():
	var saveGame = FileAccess.open(savePath, FileAccess.WRITE)
	saveGame.store_var(saveData)
	saveGame.close()

func LoadSave():
	var saveGame = FileAccess.open(savePath, FileAccess.READ)
	saveData = saveGame.get_var()
	saveGame.close()
	HighScore.First = saveData["top"]
	HighScore.Second = saveData["two"]
	HighScore.Third = saveData["three"]
	HighScore.Fourth = saveData["four"]
	HighScore.Third = saveData["five"]

func _on_menu_chosen(item):
	match item:
		PLAY:
			get_tree().change_scene_to_file("res://Scenes/Game.tscn")
		HS:
			get_tree().change_scene_to_file("res://Scenes/HighScores.tscn")
		OPTIONS:
			get_tree().change_scene_to_file("res://Scenes/Options.tscn")
		QUIT:
			get_tree().quit()
