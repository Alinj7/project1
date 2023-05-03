extends Node2D
class_name Fighter

var cls=Hero.new()
var strength
var hp
var speed
var agility
var level
var weapon = preload("res://Scenes/weapon.tscn")
var skill:Skill
var is_active_fighter:bool = false
@onready var anim = $AnimatedSprite
@onready var attach_point= $attach_point
var weapon_node 
signal attack_end

func _ready():
	set_fighter_stats()
	weapon_node = weapon.instantiate()
	add_child(weapon_node)
	weapon_node.position = attach_point.position 
	
	print(get_stats())
	
	
	
func play_turn():
	pass
	
	
func attack():
	if is_active_fighter:
		$AnimationPlayer.play("attack")
		weapon_node.move()
	
func get_stats():
	var stats = "strength= " + str(cls.strength)  \
	+ " hp= "+ str(cls.hp) \
	+ " speed= "+ str(cls.speed) \
	+ " agility= "+ str(cls.agility) 
	
	return stats
	


func _on_animation_player_animation_finished(attack):
	is_active_fighter = false
	emit_signal("attack_end")
	
func set_fighter_stats():
	hp = cls.hp
	strength = cls.strength
	speed = cls.speed
	agility = cls.agility
	level = cls.level
	
	
