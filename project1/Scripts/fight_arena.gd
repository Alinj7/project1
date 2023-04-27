extends Node2D
class_name Fight_arena

var turn:int #0 and 1
@onready var hero = $Fighters/hero
@onready var enemy = $Fighters/enemy
var fighters = [hero,enemy]
var active_fighter


func change_turn():
	pass
func play_turn():
		pass
		
func _ready():
	pass
