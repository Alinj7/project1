extends Node2D
class_name Fight_arena

var turn:int #0 and 1
@onready var hero = $Fighters/hero as Fighter
@onready var enemy = $Fighters/enemy as Fighter
@onready var end_match_panel = $CanvasLayer/UI/End_mathch_panel
@onready var end_match_label = $CanvasLayer/UI/End_mathch_panel/Label
var fighters :Array[Fighter]
var attacker : Fighter
var defender : Fighter
var attacker_index = 0
var defender_index = 1

var attacker_chance: int #between 1 to 5
var defender_chance:int #between 1 to 5
var dice : int 
var rng 
var attack_power:int
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
	rng = RandomNumberGenerator.new()
	rng.randomize()
	hero.position = $spawn_points/hero_point.position
	enemy.position = $spawn_points/enemy_point.position
	
	initialize_ui()
	
	fighters.append(hero)
	fighters.append(enemy)
	#get fighters weapons to easier use
	hero_weapon = hero.get_child(hero.get_child_count()-1) as Weapon_script
	enemy_weapon = enemy.get_child(enemy.get_child_count()-1) as Weapon_script
	
	#hardcoding for test
	#hero
	hero.speed = 41
	hero.strength = 50
	hero.agility = 43
	hero_weapon.speed_factor = 1
	hero_weapon.strength_factor = 1
	hero_weapon.agility_factor = 3
	#enemy
	enemy.speed = 42
	enemy.strength = 48
	enemy.agility = 43
	enemy_weapon.speed_factor = 1
	enemy_weapon.strength_factor = 2
	enemy_weapon.agility_factor = 0
	
	add_weapon_power(hero, hero_weapon)
	add_weapon_power(enemy,enemy_weapon)
	
	set_first_fighter()
	play_turn()
	
	
	

func change_turn():
	if attacker_index == 0:
		attacker_index = 1
		defender_index = 0
	elif attacker_index == 1:
		attacker_index= 0
		defender_index = 1
	fighters[attacker_index].is_attacker = true
	fighters[defender_index].is_attacker = false
	attacker = fighters[attacker_index]
	defender = fighters[defender_index]
	emit_signal("next_attack")
func play_turn():
	attacker_attack()
		

func set_first_fighter():
	#speed determines first attacker
	if hero.speed > enemy.speed:
		hero.is_attacker = true
		enemy.is_attacker = false
		attacker_index = 0
		defender_index=1
		attacker= hero
		defender = enemy
	elif enemy.speed > hero.speed:
		enemy.is_attacker = true
		hero.is_attacker = false
		attacker_index = 1
		defender_index=0
		attacker = enemy
		defender = hero
	else: print("cant determine attacker and defender: " + str(hero.speed) + " , "  + str(enemy.speed))
	print("***set_first_fighter " + str(attacker.speed) + ", " + str(defender.agility))
func attacker_attack():
	#print("attacker is hero ") if hero.is_attacker == true  else print("attacker is enemy")
#	for i in fighters:
#		if i.is_attacker == true :
#			i.attack()
#			#i.is_attacker = false
#			#print("attack finished")
	fighters[attacker_index].attack()
	print("***attacker_attack " + str(attacker.speed) + ", " + str(defender.agility))
			

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


func damage(fighter:Fighter):
		attack_power = get_attack_power()
		fighter.hp -= attack_power

func _on_hero_attack_end():
	#print("hero attack ended")
	if defender == enemy:
		damage(enemy)
		if enemy.hp <0: enemy.hp = 0
		if !check_end(): change_turn()
	else: print("something weird happened in on_hero_attack")


func _on_enemy_attack_end():
	#print("enemy attack ended")
	if defender==hero:
		damage(hero)
		if hero.hp <0: hero.hp = 0
		if !check_end(): change_turn()
	else:print("something weird happened in on_enemy_attack")
		


func _on_next_attack():
	attacker_attack()
	

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
		i.is_attacker = false
		end_match_panel.visible = true
		if hero_won: end_match_label.text = "YOU WON"
		else : end_match_label.text = "YOU LOST"
		
		
		


func _on_texture_button_pressed():
	#todo : show rewards for winning or go to main scene for loosing
	end_match_panel.visible = false 

func get_attack_power():
	attacker_chance = rng.randi_range(1,5)
	defender_chance  = rng.randi_range(1,5)
	dice = rng.randi_range(0,5)
	print("at chance: " + str(attacker_chance) + "df chance: " + str(defender_chance) + "dice: " + str(dice))
	if attacker.speed > defender.agility:
		#print("*** " + str(attacker.speed) + ", " + str(defender.agility))
		if attacker_chance > defender_chance:
			if dice == 1:
				attack_power = attacker.strength * 2
				#print("attacker spd is more,attacker chance is more and dice is: " + str((dice)) + "and attack power is: " + str(attack_power))
			else:
				attack_power = dice * dice
				#print("attacker spd is more,attacker chance is more and dice is: " + str((dice)) + "and attack power is: " + str(attack_power))
		elif attacker_chance < defender_chance:
			if dice == 1:
				attack_power = attacker.strength
				#print("attacker spd is more,attacker chance is less and dice is: " + str((dice)) + "and attack power is: " + str(attack_power))
			else:
				dice +=1
				attack_power = dice * dice
				#print("attacker spd is more,attacker chance is less and dice is: " + str((dice)) + "and attack power is: " + str(attack_power))
		else: 
			#print("attacker speed is more, chances are equal")
			attack_power = dice * dice
	elif attacker.speed  < defender.agility:
		#print("*** " + str(attacker.speed) + ", " + str(defender.agility))
		if attacker_chance > defender_chance:
			attack_power = attacker.strength
			#print("attacker spd is less,attacker chance is more and dice is: " + str((dice)) + "and attack power is: " + str(attack_power))
		elif attacker_chance < defender_chance:
			if dice == 1:
				attack_power = 0
				#print("attacker spd is less,attacker chance is less and dice is: " + str((dice)) + "and attack power is: " + str(attack_power))
				#miss happens
				print("attack missed. oops!!")
			else:
				attack_power = attacker.strength - (dice * dice)
				#print("attacker spd is less,attacker chance is less and dice is: " + str((dice)) + "and attack power is: " + str(attack_power))
		else: 
			#print("attacker speed is less, chances are equal")
			attack_power = dice * dice
	else:
		#situation that attacker speed and defender agility is equal
		#print("*** " + str(attacker.speed) + ", " + str(defender.agility))
		#print("A speed and D agility where equal"+ str(attacker.speed)+ " , "+ str(defender.agility))
		attack_power = dice * dice
	return attack_power
	
	
func get_attacker():
	for fighter in fighters:
		if fighter.is_attacker==true:
			return fighter
	
func get_defender():
	for fighter in fighters:
		if fighter.is_attacker != true:
			return fighter

func add_weapon_power(fighter:Fighter, weapon: Weapon_script):
	fighter.speed += weapon.speed_factor
	fighter.strength += weapon.strength_factor
	fighter.agility += weapon.agility_factor
