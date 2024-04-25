extends Node2D

# Script de controle principal

@onready var player : CharacterBody2D = $Level/AnimPlayer
@onready var hud : CanvasLayer = $HUD
@onready var sceneLimit : Marker2D = $Level/SceneLimit

var gameScore : int = 0
var currentScene = null
var lowpass : AudioEffectLowPassFilter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Jogo começou!")
	print("Pos:"+str(player.position))
	#player.connect("jumped", _on_jumped)
	#$Music.play()
	#print("Music: ", AudioServer.get_bus_index("Music"))
	lowpass = AudioServer.get_bus_effect(1, 0) as AudioEffectLowPassFilter # Barramento 1 (Music), efeito 0 (Filtro passa-baixa)
	lowpass.cutoff_hz = 20000 # inicial, sem corte de freq.

func _physics_process(delta: float) -> void:
	if sceneLimit == null:
		player = $Level/AnimPlayer
		sceneLimit = $Level/SceneLimit		
	if player.position.y > sceneLimit.position.y:
		get_tree().change_scene_to_file("res://game_over.tscn")
	if Input.is_action_just_pressed("change"):	# mapeada para "X"	
		call_deferred("goto_scene","res://levels/level2.tscn")
		#call_deferred("goto_scene","res://game_over.tscn")
		
	# Tecla F liga/desliga o filtro passa-baixa
	if Input.is_action_just_pressed("lowpass"):
		if lowpass.cutoff_hz == 500:
			lowpass.cutoff_hz = 20000
		else:
			lowpass.cutoff_hz = 500
		
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
	
	var world := get_child(2)
	world.free()
	
	sceneLimit = null
	#var game = get_tree().get_root().get_child(0)
	add_child(currentScene)
	
	
