extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
var time := 0 
func _process(delta):
	time+=1
	text="Value:"+String(PlayerInventory.get_value())+"\n"
	text+=JSON.print(PlayerInventory.inventory," ")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
