extends Control

var menu_transaction_time : = 0.15
var menu_pos := Vector2.ZERO
var menu_size := Vector2.ZERO
var current_menu
var menu_stack = []



@onready var menu1 = $menu1
@onready var menu2 = $menu2
@onready var menu3 = $menu3



func _ready():
	menu_pos = Vector2(10.0,10.0)
	menu_size = get_viewport_rect().size
	current_menu = menu1
	$"background-sound".play()
	

	

func go_next_menu(next_menu_id: String):
	current_menu = menu1
	var next_menu = get_menu(next_menu_id)
	var tween:Tween = create_tween()
	tween.tween_property(current_menu, "position", Vector2(-menu_size.x,0.0), menu_transaction_time)
	tween.tween_property(next_menu, "position", menu_pos  , menu_transaction_time)  
	tween.play()
	menu_stack.append(current_menu)
	print(current_menu)
	current_menu = next_menu
	

func go_back_menu():
	#current_menu = menu2
	var tween:Tween = create_tween()
	var previous_menu = menu_stack.pop_back()
	if previous_menu != null:
		tween.tween_property(current_menu, "position", Vector2(menu_size.x ,0.0), menu_transaction_time)  
		tween.tween_property(previous_menu, "position", menu_pos  , menu_transaction_time) 
		tween.play()


#get menu from menu id
func get_menu(menu_id:String) -> Control:
	match menu_id:
		"menu1":
			return menu1
		"menu2":
			return menu2
		"menu3":
			return menu3
		_:
			return menu1

func _process(delta):
	if $"background-sound".playing == false:
		$"background-sound".play()



func _on_button_2_pressed() -> void:
	go_next_menu("menu2")



func _on_back_pressed() -> void:
	go_back_menu()
	$"transition-sound".play()


func _on_button_pressed():
	go_next_menu("menu2")
	$"transition-sound".play()


func _on_menu_3_back_pressed():
	go_back_menu()
	$"transition-sound".play()

func _on_gomenu_3_pressed():
	go_next_menu("menu3")
	$"transition-sound".play()


func _on_battlebutton_pressed():
	$"battle-button-sound".play()
	get_tree().change_scene_to_file("res://Scenes/fight_arena.tscn")
	


func _on_charactereguip_pressed():
	$"eguip-sound".play()


func _on_eguipweapon_pressed():
	$"eguip-sound".play()


func _on_buycoin_pressed():
	$"eguip-sound".play()


func _on_buygem_pressed():
	$"eguip-sound".play()


func _on_logout_pressed():
	$"transition-sound".play()


func _on_changepassword_pressed():
	$"transition-sound".play()



func _on_showmorebutton_pressed():
	$"transition-sound".play()



func _on_searchrankingbutton_pressed():
	$"transition-sound".play()

