extends Control


var headers = []
var menu_transaction_time : = 0.15
var menu_pos := Vector2.ZERO
var menu_size := Vector2.ZERO
var current_menu
var menu_stack = []
var user_id = 0
var level = 1
var previous_xp = 50
var xp = 0
var strength = 40
var speed = 40
var agility = 40
var hell = 1000
var rng = RandomNumberGenerator.new()
var chance
var weapones = []


@onready var menu1 = $menu1
@onready var menu2 = $menu2
@onready var menu3 = $menu3

#online vars
var username = "test"
var email = "test@gmail.com"
var password = "test_password"
var repassword = "test_password" 
var log_username = "test"
var log_password = "test_password"
var myurl = "https://game.daigo.ir/api/register?username=%s&email=%s&password=%s&password_confirmation=%s"
var myurl2 = "https://game.daigo.ir/api/login?username=%s&password=%s"
var myurl3 = "https://game.daigo.ir/api/updateLastUsedAt?uuid=%s"
var url = myurl %[username,email, password, repassword]
var loginurl = myurl2 %[log_username,log_password]
var checkurl = myurl3 %[uuid]
var getusersurl = "https://game.daigo.ir/api/users"
var uuid = 0
var sign_up_error = "none" 
var timer = Timer.new()
var test = 0

func _ready():
	$"menu2/sign-in-box".visible = false
	$"menu2/sign-up-box/sign-up-menu/error-control".visible = false
	$"menu2/sign-up-box/Accept-terms".visible = false
	$getusersRequest.request_completed.connect(_on_getusers_request_completed)
	$getusersRequest.request(getusersurl)
	menu_pos = Vector2(10.0,10.0)
	menu_size = get_viewport_rect().size
	current_menu = menu1
	$"background-sound".play()
	$"menu1/menu1-base/ability-bars/Strength-bar".max_value = 100
	$"menu1/menu1-base/ability-bars/speed-bar".max_value = 100
	$"menu1/menu1-base/ability-bars/agility-bar".max_value = 100
	$"menu2/sign-up-box".visible = false

func _on_checktimeout_timeout():
	$checkRequest.request_completed.connect(_on_check_request_completed)
	$checkRequest.request(checkurl)
	print(checkurl)



func _on_check_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var string_body = body.get_string_from_utf8()
	
	print(uuid)
	print(response_code)
	print(json)

func _on_getusers_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var string_body = body.get_string_from_utf8()	
	print(response_code)
	print(json)

func _on_login_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var string_body = body.get_string_from_utf8()
	print(response_code)
	print('login jason:',json)
	
	if "Invalid username or password" in string_body:
		print("Invalid username or password")
	else:
		uuid = json.user.uuid
	
	
func _on_signup_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var string_body = body.get_string_from_utf8()
	if "Password must be at least 6 characters" in string_body:
		sign_up_error = "Password must be at least 6 characters"
		print("Password must be at least 6 characters")
	elif "Username is requaired" in string_body:
		sign_up_error = "Username is requaired"
	elif "Username most not be more than 50 characters" in string_body:
		sign_up_error = "Username most not be more than 50 characters"
	elif "Email  is requaired" in string_body:
		sign_up_error = "Email  is requaired"
	elif "The email format is invalid" in string_body:
		sign_up_error = "The email format is invalid"
	elif "Email most not be more than 50 characters" in string_body:
		sign_up_error = "Email most not be more than 50 characters"
	elif "The email entered is already taken" in string_body:
		sign_up_error = "The email entered is already taken"
	elif "Password is requaired" in string_body:
		sign_up_error = "The email entered is already taken"
	elif "Password must be at least 6 characters" in string_body:
		sign_up_error = "The email entered is already taken"
	elif "password confirmation does not match" in string_body:
		sign_up_error = "password confirmation does not match"
	else:
		sign_up_error = "none"
	print(sign_up_error)
	#print(result)
	#print(response_code)
	#print(json)
func _on_signupbutton_pressed():
	username = $"menu2/sign-up-box/sign-up-menu/user-name-label" .text 
	password = $"menu2/sign-up-box/sign-up-menu/password-label".text 
	repassword = $"menu2/sign-up-box/sign-up-menu/repassword-label".text
	log_username = username
	log_password = password 
	email = $"menu2/sign-up-box/sign-up-menu/email-label".text 
	url = myurl %[username,email, password, repassword]
	loginurl = myurl2 %[log_username,log_password]
	checkurl = myurl3 %[uuid]
	$SignupRequest.request_completed.connect(_on_signup_request_completed)
	$SignupRequest.request(url)
	$LoginRequest.request_completed.connect(_on_login_request_completed)
	$LoginRequest.request(loginurl)	
	$getusersRequest.request_completed.connect(_on_getusers_request_completed)
	$getusersRequest.request(loginurl)	
	$"menu2/sign-up-box/Accept-terms".visible = true

func _on_acceptterms_confirmed():
	if sign_up_error == "none":
		print("your signed up!")
	else:
		$"menu2/sign-up-box/sign-up-menu/error-control".visible =true
		$"menu2/sign-up-box/sign-up-menu/error-control/text-error-label".text = sign_up_error
	
func _on_llogout_pressed():
	$"menu2/sign-up-box".visible =true




func _on_closesignin_pressed():
	$"menu2/sign-in-box".visible = false
func _on_closesignup_pressed():
	$"menu2/sign-up-box".visible =false
	
func _on_cchangepassword_pressed():
	$"menu2/sign-in-box".visible = true	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
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
	$"menu1/menu1-base/lavel-up-box/level-up-box-to-box/level-label".text = str(level)
	$"menu1/menu1-base/lavel-up-box/level-up-box-to-box/level-up-bar".value = xp	
	$"menu1/menu1-base/lavel-up-box/level-up-box-to-box/level-up-bar".max_value = previous_xp	
	$"menu1/menu1-base/ability-bars/Strength-bar".value = strength
	$"menu1/menu1-base/ability-bars/speed-bar".value = speed
	$"menu1/menu1-base/ability-bars/agility-bar".value = agility
	checkurl = myurl3 %[uuid]
	#if sign_up_error != "none":
	#	$"menu2/sign-up-box/sign-up-menu/error-control/sign-error-text".text = sign_up_error
	


	
	
	level_up()
	
	if user_id == 0:
		$"menu2/menu2-base/menu2-base-to-base/setting/setting-tabs/Profile/profile-box/log-out-box/llog-out".text = "Sign-Up"
		$"menu2/menu2-base/menu2-base-to-base/setting/setting-tabs/Profile/profile-box/changhe-password-box/cchange-password".text = "Sign-In"
		$"menu2/menu2-base/menu2-base-to-base/setting/setting-tabs/Profile/profile-box/user-id-box/uuser-id".text = "Please Sign..."
		$"menu2/menu2-base/menu2-base-to-base/setting/setting-tabs/Profile/profile-box/user-name-box/uuser-name".text = "Please Sign..."
	else:
		$"menu2/menu2-base/menu2-base-to-base/setting/setting-tabs/Profile/profile-box/log-out-box/llog-out".text = "Log-Out"
		$"menu2/menu2-base/menu2-base-to-base/setting/setting-tabs/Profile/profile-box/changhe-password-box/cchange-password".text = "Change-Password"	
		$"menu2/menu2-base/menu2-base-to-base/setting/setting-tabs/Profile/profile-box/user-id-box/uuser-id".text = "user_id"
		$"menu2/menu2-base/menu2-base-to-base/setting/setting-tabs/Profile/profile-box/user-name-box/uuser-name".text = "user_name"
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
	
	

func level_up():
	if level<20:
		if xp == previous_xp+50 or xp >previous_xp+50:
			previous_xp = xp
			xp -=xp
			level+=1
			chance = int(rng.randf_range(1,3))
			print ("chance =" , chance )
			if chance ==1.0:
					strength +=1
			if chance ==2.0:
					speed +=1
			if chance ==3.0:
					agility +=1 
			
	elif level<40:
		if xp == previous_xp+100:
			previous_xp = xp
			xp = 0
			level+=1
	elif level<60:
		if xp == previous_xp+150:
			previous_xp = xp
			xp = 0
			level+=1
	elif level<80:
		if xp == previous_xp+200:
			previous_xp = xp
			xp = 0
			level+=1
	elif level<100:
		if xp == previous_xp+250:
			previous_xp = xp
			xp = 0
			level+=1				
		






func _on_chest_3_pressed():
	xp += 20
















