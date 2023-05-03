extends Node2D
class_name Fight_arena

var turn:int #0 and 1
@onready var hero = $Fighters/hero as Fighter
@onready var enemy = $Fighters/enemy as Fighter
@onready var end_match_panel = $CanvasLayer/UI/End_mathch_panel
@onready var end_match_label = $CanvasLayer/UI/End_mathch_panel/Label
var fighters :Array[Fighter]
var active_fighter
var active_fighter_index = 0
signal next_attack
signal end_match
var hero_weapon
var enemy_weapon 

var game_ended  =false
var hero_won = false


@onready var hero_health_bar = $CanvasLayer/UI/hero_bar
@onready var enemy_health_bar = $CanvasLayer/UI/enemy_bar
@onready var hero_hp_label = $CanvasLayer/UI/hero_hp_label
@onready var enemy_hp_label = $CanvasLayer/UI/enemy_hp_label
func _ready():
	hero.position = $spawn_points/hero_point.position
	enemy.position = $spawn_points/enemy_point.position
	
	initialize_ui()
	
	fighters.append(hero)
	fighters.append(enemy)
	#get fighters weapons to easier use
	hero_weapon = hero.get_child(hero.get_child_count()-1) as Weapon_script
	enemy_weapon = enemy.get_child(enemy.get_child_count()-1) as Weapon_script
	
	#hardcoding for test
	hero_weapon.damage = 150
	enemy_weapon.damage =225

	set_first_fighter()
	play_turn()
	
	
	

func change_turn():
	if active_fighter_index == 0:
		active_fighter_index = 1
	elif active_fighter_index == 1:
		active_fighter_index = 0
	fighters[active_fighter_index].is_active_fighter = true
	emit_signal("next_attack")
func play_turn():
	active_figheter_attack()
		

func set_first_fighter():
	hero.is_active_fighter = true

func active_figheter_attack():
	for i in fighters:
		if i.is_active_fighter == true :
			i.attack()
			print("attack finished")
			

func _process(delta):
		hero_health_bar.value = hero.hp
		enemy_health_bar.value = enemy.hp
		hero_hp_label.text = str(hero.hp)
		enemy_hp_label.text = str(enemy.hp)


func initialize_ui():
	hero_health_bar.max_value = hero.hp
	hero_health_bar.value = hero.hp
	enemy_health_bar.max_value = enemy.hp
	enemy_health_bar.value=  enemy.hp
	hero_hp_label.text = str(hero.hp)
	enemy_hp_label.text = str(enemy.hp)


func damage(fighter:Fighter,weapon:Weapon_script):
		fighter.hp -= weapon.damage

func _on_hero_attack_end():
	print("hero attack ended")
	damage(enemy,hero_weapon)
	if enemy.hp <0: enemy.hp = 0
	if !check_end(): change_turn()


func _on_enemy_attack_end():
	print("hero attack ended")
	damage(hero,enemy_weapon)
	if hero.hp <0: hero.hp = 0
	if !check_end(): change_turn()


func _on_next_attack():
	active_figheter_attack()
	

func check_end():
	for i in fighters:
		if i.hp<=0:
			game_ended = true
			emit_signal("end_match")
			return true
	return false

func _on_end_match():
	if hero.hp<=0:hero_won = false
	elif enemy.hp <= 0 : hero_won = true
	for i in fighters:
		i.is_active_fighter = false
		end_match_panel.visible = true
		if hero_won: end_match_label.text = "YOU WON"
		else : end_match_label.text = "YOU LOST"
		
		
		


func _on_texture_button_pressed():
	#todo : show rewards for winning or go to main scene for loosing
	end_match_panel.visible = false 
