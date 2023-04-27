extends Node2D
class_name Fighter

var cls=Hero.new()
var strength
var hp
var speed
var agility
var weapon = preload("res://Scenes/weapon.tscn")
var skill:Skill
var is_active_fighter:bool
@onready var anim = $AnimatedSprite
@onready var attach_point=$attach_point

func _ready():
	var weapon_node = weapon.instantiate()
	add_child(weapon_node)
	weapon_node.position = attach_point.position
	print(get_stats())
	
	
func play_turn():
	pass
func attack():
	pass
	
func get_stats():
	var stats = "strength= " + str(cls.strength)  \
	+ " hp= "+ str(cls.hp) \
	+ " speed= "+ str(cls.speed) \
	+ " agility= "+ str(cls.agility) 
	
	return stats
	
