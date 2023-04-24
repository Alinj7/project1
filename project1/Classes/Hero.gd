class_name Hero

var xp: int
var level : int
var strength : int
var stamina:int
var speed:int
var agility:int
var items:Array[Item] 
var current_weapon : Weapon
var current_skill : Skill


func _init():
    xp=0
    level=1
    strength=1
    stamina=1
    speed=1
    agility=1

