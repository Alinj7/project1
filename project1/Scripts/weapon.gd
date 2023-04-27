extends Node2D


@export var title :String = "knife"
@export var damage : int =100
@export var level : int = 1
@onready var sprite = $Sprite2D

var cls = Weapon.new(title,damage,level)

func _ready():
	get_weapon_stats()


func get_weapon_stats():
	var info = cls.title + " damage: " + str(cls.damage) + " level: " + str(cls.level)
	print(info)
	return info
	
func _init(name:String,dmg:int,lvl:int):
	title = name
	damage = dmg
	level = lvl
	
	

