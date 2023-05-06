extends Node2D
class_name Fighter

var cls
var strength
var hp :int = 1000
var speed
var agility
var level
var weapon = preload("res://Scenes/weapon.tscn")
var skill:Skill
var is_attacker:bool = false
@onready var anim = $AnimatedSprite
@onready var attach_point= $attach_point
var weapon_node 
signal attack_end

func _init(hp=1000,speed=40,strength=40,agility=40):
	cls = Hero.new(hp,speed,strength,agility)
	hp= cls.hp
	speed =  cls.speed
	strength = cls.strength
	agility = cls.agility

func _ready():
	set_fighter_stats()
	weapon_node = weapon.instantiate()
	add_child(weapon_node)
	weapon_node.position = attach_point.position 
	
	print(get_stats())
	
	
	
func play_turn():
	pass
	
	
func attack():
	if is_attacker:
		$AnimationPlayer.play("attack")
		weapon_node.move()
	
func get_stats():
	var stats = "strength= " + str(cls.strength)  \
	+ " hp= "+ str(cls.hp) \
	+ " speed= "+ str(cls.speed) \
	+ " agility= "+ str(cls.agility) 
	
	return stats
	


func _on_animation_player_animation_finished(attack):
	is_attacker = false
	emit_signal("attack_end")
	
func set_fighter_stats():
	hp = cls.hp
	strength = cls.strength
	speed = cls.speed
	agility = cls.agility
	level = cls.level
	
	
