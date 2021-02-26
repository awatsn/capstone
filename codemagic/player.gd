extends KinematicBody2D

var curHp : int = 10 #change later?
var maxHp : int = 10
var damage : int = 1

export (int) var maxSpeed : int = 400 #export lets edits from menu
export (int) var accel = 2000 #acceleration
var motion = Vector2()

var interactDist : int = 70

func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(accel * delta)
	else:
		apply_movement(axis * accel * delta)
	motion = move_and_slide(motion)
	
	#look_at(get_global_mouse_position()) #test

func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()
	
func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO
	
func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(maxSpeed)
	

#var vel : Vector2 = Vector2()
#var facingDir : Vector2 = Vector2()
#
#onready var rayCast = get_node("RayCast2D")
#
#func _physics_process(delta): 
#	vel = Vector2()
#	#inputs
#	if Input.is_action_pressed("move_up"):
#		vel.y -= 1
#		facingDir = Vector2(0, -1)
#	if Input.is_action_pressed("move_down"):
#		vel.y += 1
#		facingDir = Vector2(0, 1)
#	if Input.is_action_pressed("move_left"):
#		vel.x -= 1
#		facingDir = Vector2(-1, 0)
#	if Input.is_action_pressed("move_right"):
#		vel.x += 1
#		facingDir = Vector2(1, 0)
#
#	vel = vel.normalized()
#	#move player
#	move_and_slide(vel*moveSpeed)
