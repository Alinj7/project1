extends Node2D
class_name Weapon_script

@export var title :String = "knife"
var speed_factor :int =0
var strength_factor:int = 0
var agility_factor:int = 0
@export var level : int = 1
var texturePath = "res://Assets/weapons/"
var cls

#weapon names is selectable from sedtor dropdown list
@export_enum("knife", "spear", "mace", "hawk_axe","double_spear" ,
 "crystal_sword","double_sided_hawk_axe","goleden_hawk_axe","golden_double_sided_hawk_axe") var weapon_name: String


var textures_Dic = {
	"knife": "res://Assets/weapons/Knife.png",
	"spear": "res://Assets/weapons/Spear.png",
	"mace": "res://Assets/weapons/Mace.png",
	"hawk_axe": "res://Assets/weapons/Hawk_Axe.png",
	"double_spear": "res://Assets/weapons/Double_Spear.png",
	"crystal_sword": "res://Assets/weapons/Crystal_Sword.png",
	"double_sided_hawk_axe": "res://Assets/weapons/Double_Sided_Hawk_Axe.png",
	"golden_hawk_axe": "res://Assets/weapons/Golden_Hawk_Axe.png",
	"golden_double_sided_hawk_axe": "res://Assets/weapons/Golden_Double_Sided_Hawk_Axe.png",
}

func get_weapon_stats():
	var info = cls.title + " level: " + str(cls.level) 
	print(info)
	return info
func _init(title="knife", level=1,speed=0,strength=0,agility=0):
	cls= Weapon.new(title,level,speed,strength,agility)
	texturePath += weapon_name
	get_weapon_stats()
	speed_factor = cls.speed_factor
	strength_factor = cls.strength_factor
	agility_factor = cls.agility_factor
func wapon_click(viewport, event, shape_idx):
	if(event.is_pressed()):
		var animation_player=get_node("Area2D/weapon_animation")
		animation_player.play("knife")
		
func move():
	#weapon move with fighter in the fight_arena scene
	$Area2D/weapon_animation.play("move")

func _ready():
	title = weapon_name
	#load weapon texture based on type
	$Area2D/Polygon2D.texture = load(textures_Dic[weapon_name])
	
