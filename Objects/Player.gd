extends KinematicBody2D

onready var water_particle = load("res://Objects/WaterParticle.tscn")
onready var timer = $FireTimer

#Movement
var speed = 300
var grav = 4000
var jump = -1000
var velocity: Vector2
var fire_ready = true

#Water
var water = 500
var min_water = 100

func _ready():
	timer.start()

func get_input():
	#Movement
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_pressed("right"):
		velocity.x += speed
		
	#Water
	if Input.is_action_pressed("squirt") and fire_ready:
		fire_ready = false
		water = min_water if water-1 < min_water else water-1
		squirt_water()

func squirt_water():
	var w = water_particle.instance()
	w.global_position = position
	w.apply_central_impulse($Cursor.position*15)
	get_tree().get_root().add_child(w)

func _process(delta):
	#Movement
	get_input()
	velocity.y += grav * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				velocity.y = jump
				
	#Water Shrinking
	scale = Vector2(water/100.0, water/100.0)

func _on_FireTimer_timeout():
	fire_ready = true
