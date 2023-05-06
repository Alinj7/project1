class_name Weapon

var title : String
var damage : int
var level : int
var speed_factor :int =0
var strength_factor:int = 0
var agility_factor:int = 0

func _init(name="knife",dmg=5,lvl=1, speed_f=0, strength_f=0,agility_f=0):
	title = name
	damage = dmg
	level = lvl
	speed_factor = speed_f
	strength_factor = strength_f
	agility_factor = agility_f
