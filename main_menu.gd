extends Control

var list_item = preload("res://list_item_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var list_items = [{
		"name":"Reymon",
		"ETA":"05/09/2024",
		"amount":"25",
	},{
		"name":"Reymon",
		"ETA":"05/09/2024",
		"amount":"25",
	},{
		"name":"Reymon",
		"ETA":"05/09/2024",
		"amount":"25",
	}]
	for item in list_items:
		crear_list_item_button({
		"name":item.name,
		"ETA":item.ETA,
		"amount":item.amount,
	})

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pedir_button_pressed():
	get_tree().change_scene_to_file("res://pedir_producto.tscn")


func _on_crear_producto_button_pressed():
	get_tree().change_scene_to_file("res://crear_producto.tscn")

func _button_pressed():
	get_tree().change_scene_to_file("res://estado_pedido.tscn")

func crear_list_item_button(list_item_data):
	var list_item_instance = list_item.instantiate()
	list_item_instance.get_node("HBoxContainer").get_node("Nombre").text = list_item_data.name
	list_item_instance.get_node("HBoxContainer").get_node("ETA").text = list_item_data.ETA
	list_item_instance.get_node("HBoxContainer").get_node("Cantidad").text = list_item_data.amount
	list_item_instance.pressed.connect(self._button_pressed.bind())
	%ListContainer.add_child(list_item_instance)
