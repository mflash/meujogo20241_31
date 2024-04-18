extends Node2D

# Script de controle principal

@onready var player : CharacterBody2D = $AnimPlayer
@onready var hud : CanvasLayer = $HUD

var gameScore : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	print("Jogo começou!")
	print("Pos:"+str(player.position))
	#player.connect("jumped", _on_jumped)

# chamado via call_group
func updateScore():
	print("updateScore do game!")
	gameScore += 1
	# Pede para o hud atualizar o score na tela
	hud.setScore(gameScore)
	
# callback do signal jumped
func _on_jumped():
	print("Jumped!")
	updateScore()
	
	
