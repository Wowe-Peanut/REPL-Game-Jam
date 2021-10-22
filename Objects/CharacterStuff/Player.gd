extends KinematicBody2D

onready var water_particle = load("res://Objects/CharacterStuff/WaterParticle.tscn")
onready var timer = $FireTimer

#Movement
var speed = 200
var grav = 4000
var jump = -1500
var friction = .25
var accel = 0.25
var velocity: Vector2

#Water
var water:float = 100
var water_drain = 3
var min_water = 20

#Squirting
var fire_ready = true
var fire_power = 3

func _ready():
	timer.start()

func _process(delta):
	#Movement
	get_input()
	velocity.y += grav * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				velocity.y = jump*(30/water)
	scale = Vector2(water/100, water/100)

func get_input():
	#Movement
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
	if Input.is_action_pressed("left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed * (100/water), accel)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	
		
	#Water
	if Input.is_action_pressed("squirt") and fire_ready:
		fire_ready = false
		if water > min_water:
			if water-water_drain >= min_water:
				squirt_water(water_drain)
				water = water-water_drain
			else:
				squirt_water(water-min_water)
				water = min_water
	
	if Input.is_action_just_pressed("restart"):
		get_tree().get_root().get_node("Main").restart_level()

func squirt_water(amount):
	var w = water_particle.instance()
	w.global_position = position
	w.apply_central_impulse($Cursor.position*fire_power)
	w.amount = amount
	get_tree().get_root().add_child(w)

func _on_FireTimer_timeout():
	fire_ready = true
