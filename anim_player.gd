extends CharacterBody2D

@export var speed = 300.0
@export var jump_speed := -1000.0
@export var gravity := 2500.0
@onready var sprite = $PlayerSprite
@onready var box := preload("res://box.tscn")

signal jumped

#func _ready() -> void:
	#sprite = $PlayerSprite	
	
func get_8way_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func get_side_input():	
	velocity.x = 0
	var vel := Input.get_axis("left", "right")
	var jump := Input.is_action_just_pressed('jump')

	if is_on_floor() and jump:
		velocity.y = jump_speed
		#jumped.emit()
		
		# Usando grupos:
		get_tree().call_group("HUD", "updateScore")
		
		# Instanciando cenas (nodos)
		var b := box.instantiate()
		# global_position para pegar a pos. no universo
		b.position = global_position
		# owner é o "dono" do nodo, ou seja, a raiz da cena
		owner.add_child(b)
	velocity.x = vel * speed
	
func animate():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()
		
func animate_side():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		
func move_8way(delta):
	get_8way_input()
	animate()
	move_and_slide()
	
func move_side(delta):	
	velocity.y += gravity * delta
	get_side_input()
	animate_side()
	move_and_slide()
	#print(velocity * delta)

func _physics_process(delta):
	#move_8way()
	move_side(delta)
