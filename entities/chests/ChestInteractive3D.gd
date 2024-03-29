extends KinematicBody

const ACCEL = 460
const MAX_SPEED = 225
var velocity = Vector3.ZERO
const ATTRACT_DIST= 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var inventory_ui_scene
export(NodePath) var inventory_path
export(String,MULTILINE) var inventory_contents

var open = false
var inventory
signal attention_event(data) 
#
# data["Form"] : "Interact", "Destroy", "Player" ...
# data["Type"] : "Container" ...
# data[ :Type + " Type" ] = "Chest" ...
# data["Disruption level"] = 0....10

func emit_attention_event(attention_event:InteractChestAttentionEvent):
	attention_event.object = self
	emit_signal("attention_event",attention_event)

#signal attention_event(object,data)

func inventory_source():
	return get_node(inventory_path)
# Called when the node enters the scene tree for the first time.
func _ready():
	inventory = get_node(inventory_path).get_inventory()
	print("Inventory Contents:",inventory_contents)
	inventory.load_json(inventory_contents)
	pass # Replace with function body.

#func _physics_process(delta):
#	velocity = velocity.move_toward(Vector3(0,MAX_SPEED,0),ACCEL*delta)
#	velocity = move_and_slide(velocity,Vector3.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func interact(event,player):
	if event.is_action_pressed("interact"):
		if !open:
			var chest_inventory_ui=inventory_ui_scene.instance()
#			player.interactive_ui = chest_inventory_ui
#			chest_inventory_ui.inventory=inventory_source()
#			chest_inventory_ui.ui = player.user_interface
			emit_attention_event(InteractChestAttentionEvent.new().init(self,player,0).init_2(InteractChestAttentionEvent.InteractionType.OPEN,player))
			player.user_interface.show_inventory_ui(chest_inventory_ui,self)
		else: 
			player.user_interface.hide_inventory_ui(player.interactive_ui,self)




func _on_ChestZone_body_entered(body):
	if body.has_method("add_interactive"):
		body.add_interactive(self)


func _on_ChestZone_body_exited(body):
	if body.has_method("remove_interactive"):
		body.remove_interactive(self)
		
	pass # Replace with function body.

