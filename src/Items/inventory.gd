extends Node

var items: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func add_item(item):
	items.push_back(item)


func drop_item(item):
	items.erase(item)
