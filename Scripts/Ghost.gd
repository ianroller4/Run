extends CharacterBody2D

var player : Player

@export var speed := 50

@onready var nav := $Navigation as NavigationAgent2D

var dirVector : Vector2

func _ready():
	add_to_group("Enemy")
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if not Global.GameOver:
		if not Global.paused:
			Move(delta)

func UpdateDirectionVec():
	dirVector = to_local(nav.get_next_path_position()).normalized()

func UpdateVelocity():
	velocity =  dirVector * speed

func Move(delta : float):
	UpdateDirectionVec()
	UpdateVelocity()
	move_and_collide(velocity * delta)

func CreatePath():
	nav.target_position = player.global_position

func _on_nav_timer_timeout():
	CreatePath()
