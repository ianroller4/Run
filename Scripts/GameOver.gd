extends Control

@onready var RETRY := $Menu/Retry
@onready var HS := $"Menu/High Scores"
@onready var QUIT := $Menu/Quit

var savePath = "user://saveGame.save"
var saveData = {"top": 0, "two": 0, "three": 0, "four": 0, "five": 0}

func _ready():
	if not FileAccess.file_exists(savePath):
		CreateSave()
	else:
		LoadSave()
	UpdateHighScore()
	Save()

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

func Save():
	saveData["top"] = HighScore.First
	saveData["two"] = HighScore.Second
	saveData["three"] = HighScore.Third
	saveData["four"] = HighScore.Fourth
	saveData["five"] = HighScore.Fifth
	
	var saveGame = FileAccess.open(savePath, FileAccess.WRITE)
	saveGame.store_var(saveData)
	saveGame.close()

func UpdateHighScore():
	var cs := HighScore.CurrentScore
	if  cs > HighScore.Fifth:
		if cs > HighScore.First:
			HighScore.Fifth = HighScore.Fourth
			HighScore.Fourth = HighScore.Third
			HighScore.Third = HighScore.Second
			HighScore.Second = HighScore.First
			HighScore.First = cs
		elif cs > HighScore.Second:
			HighScore.Fifth = HighScore.Fourth
			HighScore.Fourth = HighScore.Third
			HighScore.Third = HighScore.Second
			HighScore.Second = cs
		elif cs > HighScore.Third:
			HighScore.Fifth = HighScore.Fourth
			HighScore.Fourth = HighScore.Third
			HighScore.Third = cs
		elif cs > HighScore.Fourth:
			HighScore.Fifth = HighScore.Fourth
			HighScore.Fourth = cs
		else:
			HighScore.Fifth = cs

func _on_menu_chosen(item):
	match item:
		RETRY:
			get_tree().change_scene_to_file("res://Scenes/Game.tscn")
		HS:
			get_tree().change_scene_to_file("res://Scenes/HighScores.tscn")
		QUIT:
			get_tree().quit()
