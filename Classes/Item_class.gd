class_name Item

"""items example can be like "speed1" or "hp5"
that is explanatory """

var name:String
enum TYPE {STRENGTH=0, SPEED=1, HP=2, AGILITY=3} 
var value:int #1 to 5

func _init(mName,mType, mValue):
	name = mName
	mValue=value
	mType



func add_value(stat):
	stat+=value
