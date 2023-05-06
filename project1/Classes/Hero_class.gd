class_name Hero

var xp: int
var hp: int
var level : int
var strength : int
var stamina:int
var speed:int
var agility:int
var items:Array[Item] 
var current_weapon : Weapon
var current_skill : Skill


func _init(mHp,mSpeed,mStrength,mAgility,mLevel=1,):
	xp=0
	hp = mHp
	level=mLevel
	strength=mStrength
	stamina=100
	speed=mSpeed
	agility=mAgility


