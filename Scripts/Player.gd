extends CharacterBody2D

class_name Player

@onready var sprite := $Sprite as Sprite2D

@onready var iTimer := $InvincibleTimer as Timer
@onready var dTimer := $DashTimer as Timer
@onready var drTimer := $DashReadyTimer as Timer

@onready var hitBox := $HitBox

var inputVec : Vector2

var REGULAR = preload("res://Assets/Art/TempPlayer.png")
var SHIELD = preload("res://Assets/Art/Player.png")
var DASH = preload("res://Assets/Art/Dash.png")

var walkSpeed := 200
var dashSpeed := 1000

var speed : int

var lives := 3

var invincible := false

var enemiesTouching := 0

var dashAvailable := false

signal spawn

func _ready():
	speed = walkSpeed
	sprite.texture = REGULAR
	$Timer.start()

func _physics_process(delta):
	if not Global.GameOver:
		if not Global.paused:
			Move(delta)
		if Input.is_action_just_released("ui_space") and dashAvailable:
			Dash()
		UpdateScore()
		if Input.is_action_just_released("ui_enter"):
			spawn.emit()

func UpdateScore():
	$"Player Hud/Score".text = str(HighScore.CurrentScore)

func UpdateInputVec():
	inputVec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()

func UpdateVelocity():
	velocity = inputVec * speed

func UpdateRotation():
	if inputVec != Vector2.ZERO:
		rotation = velocity.angle()

func Move(delta : float):
	UpdateInputVec()
	UpdateVelocity()
	UpdateRotation()
	move_and_collide(velocity * delta)

func Dash():
	sprite.texture = DASH
	speed = dashSpeed
	dTimer.start()
	dashAvailable = false
	$"Player Hud/Dash Ready".hide()
	drTimer.start()
	set_collision_mask_value(3, false)
	hitBox.set_collision_mask_value(3, false)
	hitBox.set_collision_mask_value(5, false)

func StopDash():
	if not invincible:
		sprite.texture = REGULAR
	else:
		sprite.texture = SHIELD
	speed = walkSpeed
	set_collision_mask_value(3, true)
	hitBox.set_collision_mask_value(3, true)
	hitBox.set_collision_mask_value(5, true)

func StopInvincible():
	sprite.texture = REGULAR
	invincible = false

func UpdateHealth():
	lives = 0 if ((lives - 1) < 0) else lives - 1
	match lives:
		2:
			$"Player Hud/Health 3".hide()
		1:
			$"Player Hud/Health 2".hide()
		0:
			$"Player Hud/Health 1".hide()
	
	if lives == 0:
		Global.GameOver = true

func TakeDamage():
	UpdateHealth()
	iTimer.start(2)
	sprite.texture = SHIELD
	invincible = true

func _on_invincible_timer_timeout():
	StopInvincible()
	if enemiesTouching > 0:
		TakeDamage()

func _on_dash_timer_timeout():
	StopDash()

func _on_hit_box_body_entered(body):
	if body.is_in_group("Enemy") and not invincible:
		enemiesTouching += 1
		TakeDamage()

func _on_hit_box_body_exited(body):
	if body.is_in_group("Enemy"):
		if not (enemiesTouching - 1) < 0:
			enemiesTouching -= 1

func _on_dash_ready_timer_timeout():
	dashAvailable = true
	$"Player Hud/Dash Ready".show()


func _on_timer_timeout():
	dashAvailable = true
