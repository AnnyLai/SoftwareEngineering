extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.startGame == 0:
		Global.storage.resize(100)
		Global.storage.fill(0)
		Global.store = 0
		Global.lastrand = 0
		Global.startGame = 1
		Global.currentCard = 0
		Global.currentStorage = 0
		Global.currentStorageStart = 0




