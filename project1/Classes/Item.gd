class_name Item

var name:String
var types =["Strength",  "Speed", "Hp" , "Agility"] 

enum TYPE {STRENGTH, SPEED, HP, AGILITY} 

var value:int #1 to 5
var type:String

func _init(mType, mValue):
    mValue=value
    #todo



func add_value(stat):
    stat+=value