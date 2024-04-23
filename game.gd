extends Node2D

# Script de controle principal

@onready var player : CharacterBody2D = $Level/AnimPlayer
@onready var hud : CanvasLayer = $HUD
@onready var sceneLimit : Marker2D = $Level/SceneLimit

var gameScore : int = 0
var currentScene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Jogo começou!")
	print("Pos:"+str(player.position))
	#player.connect("jumped", _on_jumped)

func _physics_process(delta: float) -> void:
	if sceneLimit == null:
		player = $Level/AnimPlayer
		sceneLimit = $Level/SceneLimit		
	if player.position.y > sceneLimit.position.y:
		get_tree().change_scene_to_file("res://game_over.tscn")
	if Input.is_action_just_pressed("change"):	# mapeada para "X"	
		call_deferred("goto_scene","res://level2.tscn")
		#call_deferred("goto_scene","res://game_over.tscn")
		
# chamado via call_group
func updateScore():
	#print("updateScore do game!")
	gameScore += 1
	# Pede para o hud atualizar o score na tela
	hud.setScore(gameScore)
	
# callback do signal jumped
func _on_jumped():
	#print("Jumped!")
	updateScore()
	
func goto_scene(path: String):
	print("Total children: "+str(get_child_count()))
	
	var res := ResourceLoader.load(path)
	currentScene = res.instantiate()
	
	var world := get_child(1)
	world.free()
	
	sceneLimit = null
	#var game = get_tree().get_root().get_child(0)
	add_child(currentScene)
	
	
