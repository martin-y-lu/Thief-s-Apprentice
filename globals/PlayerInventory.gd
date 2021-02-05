extends Inventory

var holding_item = null

var open = false
var open_container_slot=null
var open_container_ui=null
var InventoryClass = load("res://entities/Inventory.gd")


func remove_holding_item():
	if holding_item!=null:
		holding_item.queue_free()
		holding_item=null
		
func _ready():
	width = 6
	height = 10
	
var housing_inventory
func open_container(slot,inventory_of):
	var item=slot.item
	var props = JsonData.properties(item.item_name)
	var inventory_ui_path = "res://ui/inventories/"+props["InventoryUISceneName"]+".tscn" 
	var container_inventory_ui = load(inventory_ui_path).instance()
#	var container_inventory = inventory_of.inventory[slot.slot_index]["Inventory"]
#	if container_inventory ==null:
	var container_inventory = InventoryClass.new()
	if not "Type" in inventory_of.inventory[slot.slot_index]:
		return
	if inventory_of.inventory[slot.slot_index]["Type"] != "Container":
		return
	container_inventory.inventory= inventory_of.inventory[slot.slot_index]["Initial Contents"]
	container_inventory.width= JsonData.properties(item.item_name)["Width"]
	container_inventory.height= JsonData.properties(item.item_name)["Height"]
#	inventory_of.inventory[slot.slot_index]["Inventory"]=container_inventory
	container_inventory_ui.inventory=container_inventory
	open_container_ui=container_inventory_ui
	open_container_slot=slot
	housing_inventory= inventory_of
	GameManager.user_interface.show_inventory_ui(container_inventory_ui,self)


func close_container():
	if housing_inventory:
		commit_open_container_ui_data()
		GameManager.user_interface.hide_inventory_ui(open_container_ui,self)
		open_container_ui=null
		open_container_slot=null
		open=false
func commit_open_container_ui_data():
	if housing_inventory:
		housing_inventory.inventory[open_container_slot.slot_index]["Initial Contents"]= open_container_ui.inventory.inventory
	
func prep_value_get():
	commit_open_container_ui_data()
#const SlotClass = preload("res://Slot_Test_0.gd")
#const ItemClass = preload("res://Item.gd")
#
##const Inventory = preload("res://scenes/Inventory.tscn")
#
#var player_inventory
#
#const NUM_INVENTORY_SLOTS= 60
#
#var inventory = {
#	0:["Golden Coin",5] # --> slot_index: [item_name, item_quantity]
#}
#
## Declare member variables here. Examples:
## var a = 2
## var b = "text"
#func add_item(item_name,item_quantity):
#	for ind in inventory:
#		if inventory[ind][0]==item_name:
#			#TODO: check if full
#			inventory[ind][1]+= item_quantity
#			player_inventory.inventory_slots.get_children()[ind].load_item();
#			return
#	for i in range(NUM_INVENTORY_SLOTS):
#		if !inventory.has(i):
#			inventory[i]= [item_name,item_quantity]
#			player_inventory.inventory_slots.get_children()[i].load_item();
#			return
#
#func add_item_to_empty(item: ItemClass, slot:SlotClass):
#	inventory[slot.slot_index]= [item.item_name,item.item_quantity]
#func update_slot_item(slot:SlotClass):
#	inventory[slot.slot_index]= [slot.item.item_name,slot.item.item_quantity]
#
#func remove_item(slot:SlotClass):
#	inventory.erase(slot.slot_index)
#
## Called when the node enters the scene tree for the first time.

#	pass # Replace with function body.
