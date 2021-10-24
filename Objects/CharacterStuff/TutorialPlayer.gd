extends KinematicBody2D

onready var water_particle = load("res://Objects/CharacterStuff/WaterParticle.tscn")
onready var timer = $FireTimer
onready var path = $ProjectilePath
onready var position2d = $Position2D
onready var cursor = $Cursor

onready var tutorial = get_tree().get_root().get_node("Main").get_node("HowToPlay")

#Movement
var speed = 200
var max_speed = 400
var grav = 4000
var jump = -1500
var max_jump = -1800
var friction = .25
var accel = 0.1
var velocity: Vector2

#Water
var center_height = 25
var water: float
var water_drain = 3
var min_water = 20

#Squirting
var fire_ready = true
var fire_power = 3

#animation
var animate_timer = 0

func _ready():
	timer.start()
	water = 100

func _process(delta):
	#Movement
	get_input()
	velocity.y += grav * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				velocity.y = clamp(jump*(30/water), max_jump, 0)
				
	scale = Vector2(1+ (water/100), 1+(water/100))
	animate()
	animate_timer += delta
	draw_path(delta)

func get_input():
	#Movement
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
	if Input.is_action_pressed("left"):
		dir -= 1
	if dir != 0:
		velocity.x = clamp(lerp(velocity.x, dir * speed * (100/water), accel), -max_speed, max_speed)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	#Water
	if Input.is_action_pressed("squirt") and fire_ready:
		if tutorial.current_page != 1:
			fire_ready = false
			if water > min_water:
				if water-water_drain >= min_water:
					squirt_water(water_drain)
					water = water-water_drain
				else:
					squirt_water(water-min_water)
					water = min_water
		else:
			fire_ready = false
			squirt_water(0)
			

func animate():
	scale.y *= sin(animate_timer) * .1 + 1
	scale.x *= sin(animate_timer) * .1 + 1 

func get_center_pos():
	return Vector2(position.x, position2d.get_global_position().y - center_height)

func draw_path(delta):
	path.global_scale = Vector2(2, 2)
	path.clear_points()
	var pos = Vector2(0, 0)
	var vel = Vector2(cursor.get_pos() - get_center_pos())*fire_power
	for i in 200:
		path.add_point(pos)
		vel.y += 2100 * delta
		pos += vel * delta

func squirt_water(amount):
	var w = water_particle.instance()
	w.global_position = position
	w.linear_velocity = Vector2(cursor.get_pos() - get_center_pos())*fire_power
	w.amount = amount
	get_tree().get_root().add_child(w)

func _on_FireTimer_timeout():
	fire_ready = true
