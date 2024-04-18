extends CanvasLayer

@onready var scoreLabel : Label = $Score

# Responsabilidade de atualizar o TEXTO
# do score na tela é do HUD!

func _ready() -> void:
	setScore(0)
	
func updateScore():
	print("updateScore do HUD!")
	
func setScore(score: int):
	scoreLabel.text = "Score: "+str(score)
