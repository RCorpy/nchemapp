extends Control

var list_item = preload("res://list_item_button.tscn")
var COLLECTION_ID = "users"
var petting_count = 56

#const utils = preload("res://rootscene.gd")

var list_items = [[
	{"doc_name": "nombre_producto", 
	"doc_fields": {
		"amount": 25,
		"date": { "year": 2024, "month": 9, "day": 4, "hour": 22, "minute": 0, "second": 0 },
		"container": "saco",
		"completed": true,
		"ETA": { "year": 2024, "month": 9, "day": 25, "hour": 22, "minute": 0, "second": 0 },
		"status": "por procesar",
		"payment": true, "provider": "Jaber" }, 
	"create_time": "2024-09-05T09:26:21.105996Z"}]]
# Called when the node enters the scene tree for the first time.
func _ready():
	load_item_data()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_items():
	
	for item in list_items[0]:
		crear_list_item_button({
			"fulldata":item,
			"name":item.doc_name,
			"ETA":str(item.doc_fields.ETA.day)+"/"+str(item.doc_fields.ETA.month) ,
			"amount":item.doc_fields.amount,
		})

func _on_pedir_button_pressed():
	get_tree().change_scene_to_file("res://pedir_producto.tscn")


func _on_crear_producto_button_pressed():
	get_tree().change_scene_to_file("res://crear_producto.tscn")

func _button_pressed(fulldata):
	Rootscene.set_estado_pedido_data(fulldata)
	get_tree().change_scene_to_file("res://estado_pedido.tscn")


func crear_list_item_button(list_item_data):
	var list_item_instance = list_item.instantiate()
	list_item_instance.get_node("HBoxContainer").get_node("Nombre").text = list_item_data.name
	list_item_instance.get_node("HBoxContainer").get_node("ETA").text = list_item_data.ETA
	list_item_instance.get_node("HBoxContainer").get_node("Cantidad").text = str(list_item_data.amount)
	list_item_instance.pressed.connect(self._button_pressed.bind(list_item_data.fulldata))
	%ListContainer.add_child(list_item_instance)

func load_item_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		#print("here")
		list_items = await Rootscene.list_docs_and_keys("Orders")
		#print(list_items[0][0].doc_name)
		display_items()

func save_data():
	var auth = Firebase.Auth.auth
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var panda_name = "%PandaNameLineEdit.text"
		var data: Dictionary = {
			"panda_name": panda_name,
			"petting_count": petting_count
		}
		var task: FirestoreTask = collection.update(auth.localid, data)

func load_data():
	var auth = Firebase.Auth.auth
	if !auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var task: FirestoreTask = collection.get_doc("user1")
		var finished_task: FirestoreTask = await task.task_finished
		var document = finished_task.document
		if document && document.doc_fields:
			if document.doc_fields.something:
				print(document.doc_fields.something)
			#if document.doc_fields.petting_count:
			#	petting_count = document.doc_fields.petting_count
		else:
			print(finished_task.error)
	else:
		pass
		#DELETE DOCUMENT EXAMPLE
		
		#var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		#var task: FirestoreTask = collection.delete("user2")
		
		
		#LIST EXAMPLE
		
		#var task: FirestoreTask = Firebase.Firestore.list(COLLECTION_ID)
		#var list = await task.listed_documents
		#print(list)
		##get all document names
		#for item in list:
			#print(item.doc_name)
		
		#GET DOCUMENT EXAMPLE
		
		#var collection: FirestoreCollection = Firebase.Firestore.collection(COLLETION_ID)
		#var task: FirestoreTask = collection.get_doc(DOCUMENT_ID)
		#var finished_task: FirestoreTask = await task.task_finished
		#print(finished_task.document)

		#SAVE DOCUMENT EXAMPLE

		#var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		#var task: FirestoreTask = collection.update(auth.localid, data)
