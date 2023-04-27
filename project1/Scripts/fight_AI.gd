
var rng = RandomNumberGenerator.new()
var player1:Fighter 
var player2:Fighter
var attacker 
var defender 
var turn = true
var r1
var r2
var dice
var power

func play_turn():
	if turn == true:
		attacker = player1
		defender = player2
	if turn == false:
		attacker = player2
		defender = player1
	attack()
	
func attack():
	if attacker.speed > defender.agility:
		r1 = rng.randf_range(0.0, 5.0)
		r2 = rng.randf_range(0.0, 5.0)
		if r1 > r2:
			dice = rng.randf_range(0.0, 5.0)
			if dice ==1:
				power = attacker.strength * 2
			else:
				power = dice * dice
		else: 
			dice = rng.randf_range(0.0, 5.0)
			if dice ==1:
				power = attacker.strength
			else:
				dice += 1
				power = dice * dice
	else:
		r1 = rng.randf_range(0.0, 5.0)
		r2 = rng.randf_range(0.0, 5.0)
		if r1 > r2:
			power = attacker.strength
		else:
			dice = rng.randf_range(0.0, 5.0)
			if dice ==1:
				power = 0
			else:
				power = attacker.strength - ( dice * dice )
	defender.hp - power
	play_turn()

func _ready():
	while player1.hp > 0 & player2.hp > 0:
		play_turn()
	if player1.hp <= 0:
		print("player1 is winner")		
	if player2.hp <= 0:
		print("player1 is winner")


func _process(delta):
	pass

