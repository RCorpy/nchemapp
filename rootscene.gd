extends Node

var lista_envases = []
var lista_medidas = []

var estado_pedido_data = {}
func set_estado_pedido_data(fulldata):
	estado_pedido_data = fulldata
	
func get_estado_pedido_data():
	return estado_pedido_data

func delete_doc(collection_name, doc_name):
	var collection: FirestoreCollection = Firebase.Firestore.collection(collection_name)
	var task: FirestoreTask = collection.delete(doc_name)

func list_docs_and_keys(collection_name):
	var task: FirestoreTask = Firebase.Firestore.list(collection_name)
	var list = await task.listed_documents
	var keys = []
	for item in list:
		keys.append(item.doc_name)
	return [list, keys]

func get_document(collection_name, doc_name):
	var collection: FirestoreCollection = Firebase.Firestore.collection(collection_name)
	var task: FirestoreTask = collection.get_doc(doc_name)
	var finished_task: FirestoreTask = await task.task_finished
	return finished_task.document
		
func create_or_update_document(collection_name, doc_name, data):
	var collection: FirestoreCollection = Firebase.Firestore.collection(collection_name)
	var task: FirestoreTask = collection.update(doc_name, data)

func update_option_button(option_button: OptionButton, options_array: Array):
	# Clear existing options
	option_button.clear()

	# Add items from the array
	for option in options_array:
		option_button.add_item(option)

func get_listas():
	if lista_envases==[]:
		lista_envases = await get_document("Listas", "envases")
		lista_medidas = await get_document("Listas", "medidas")

		lista_envases = lista_envases.doc_fields.values()
		lista_medidas = lista_medidas.doc_fields.values()
		
	return [lista_envases,lista_medidas]
		#return [lista_envases, lista_medidas]
