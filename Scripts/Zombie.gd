extends CharacterBody2D

class_name Enemy

var player : Player

@export var speed := 100

@onready var nav := $Navigation as NavigationAgent2D
@onready var rays := $"Ray Field"

@onready var N := $"Ray Field/N" as RayCast2D
@onready var S := $"Ray Field/S" as RayCast2D
@onready var W := $"Ray Field/W" as RayCast2D
@onready var E := $"Ray Field/E" as RayCast2D

var rayCount : int

var rayArray

var dirVector : Vector2
var correctionVector : Vector2
var finalVector : Vector2

var collsionCount : int

func _ready():
	add_to_group("Enemy")
	rayCount = rays.get_child_count()
	rayArray = rays.get_children()
	correctionVector = Vector2.ZERO
	finalVector = Vector2.ZERO
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if not Global.GameOver:
		if not Global.paused:
			Move(delta)

func UpdateDirectionVec():
	dirVector = to_local(nav.get_next_path_position()).normalized()

func UpdateForDangers():
	correctionVector = Vector2.ZERO
	collsionCount = 0;
	for i in rayCount:
		if rayArray[i].is_colliding():
			collsionCount += 1
			var dir = Vector2.DOWN.rotated(rayArray[i].rotation)
			correctionVector += dir
	if collsionCount == 0:
		correctionVector = -(correctionVector / 1).normalized()
	else:
		correctionVector = -(correctionVector / collsionCount).normalized()

func UpdateFinalVector():
	if (N.is_colliding() and S.is_colliding()) or (W.is_colliding() and E.is_colliding()):
		finalVector = dirVector
	else:
		finalVector = ((dirVector + correctionVector)/2).normalized()
		var radLimit = 135 * PI / 180
	
		if abs(dirVector.angle_to(correctionVector)) > radLimit and collsionCount > 1:
			finalVector = -finalVector

func UpdateVelocity():
	velocity =  finalVector * speed

func Move(delta : float):
	UpdateDirectionVec()
	UpdateForDangers()
	UpdateFinalVector()
	UpdateVelocity()
	move_and_collide(velocity * delta)

func CreatePath():
	nav.target_position = player.global_position

func _on_nav_timer_timeout():
	CreatePath()
