extends Node2D

@onready var zombie = preload("res://Scenes/Zombie.tscn")
@onready var ghost = preload("res://Scenes/Ghost.tscn")

@onready var pauseMenu := $"Pause Menu"

@onready var pM := $"Pause Menu/Menu" as Menu

@onready var spawnTimer := $SpawnTimer as Timer
@onready var scoreTimer := $ScoreTimer as Timer

var enemyCount := 0;

var spawnPositions := [Vector2(-160, -160), Vector2(160, -160), Vector2(160, 160), Vector2(-160, 160)]

func _ready():
	Global.paused = false
	Global.GameOver = false
	HighScore.CurrentScore = 0
	pauseMenu.hide()
	SpawnEnemy()

func _process(_delta):
	PauseCheck()
	if Global.GameOver:
		GameOver()

func PauseCheck():
	if Input.is_action_just_released("ui_pause"):
		Global.paused = false if Global.paused else true
		if Global.paused:
			pauseMenu.show()
			pM.ConfigFocus()
		else:
			pauseMenu.hide()

func SpawnEnemy():
	var pos = spawnPositions[randi_range(0, spawnPositions.size()-1)]
	
	var enemy = randi_range(0, 4)
	
	if enemy < 3:
		var z = zombie.instantiate()
		z.position = pos
		add_child(z)
	else:
		var g = ghost.instantiate()
		g.position = pos
		add_child(g)
	
	enemyCount += 1

func _on_score_timer_timeout():
	HighScore.CurrentScore += enemyCount

func _on_spawn_timer_timeout():
	SpawnEnemy()

func _on_player_spawn():
	SpawnEnemy()

func GameOver():
	get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
