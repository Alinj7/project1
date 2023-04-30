extends Node2D
@export var value : int =0
@export var type :String = "epic"
@export var items : Array = []
@export var time_in_minutes : int =10
@export var price : int =100
var cls = Chest.new()
func _init():
	print(get_chest_stats())
func get_chest_stats():
	return "value= %s type= %s items= %s time=>%s"%[value,type,items,time_in_minutes]
func _on_area_2d_input_event(viewport, event, shape_idx):
	if(event.is_pressed()):
		var animation_player=get_node("Area2D/chest_animations")
		animation_player.play("chest_open")
		
		
