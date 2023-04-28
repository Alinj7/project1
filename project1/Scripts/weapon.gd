extends Node2D


@export var title :String = "knife"
@export var damage : int =100
@export var level : int = 1

var cls = Weapon.new(title,damage,level)
func get_weapon_stats():
	var info = cls.title + " damage: " + str(cls.damage) + " level: " + str(cls.level)
	print(info)
	return info
func _init():
	get_weapon_stats()
func wapon_click(viewport, event, shape_idx):
	if(event.is_pressed()):
		var animation_player=get_node("Area2D/weapon_animation")
		animation_player.play("knife")
