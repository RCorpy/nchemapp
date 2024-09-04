extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	if Firebase.Auth.check_auth_file():
		%StateLabel.text = "Logged in"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_login_button_pressed():
	var password = $VBoxContainer/PasswordEdit.text
	var user = $VBoxContainer/UserEdit.text
	
	Firebase.Auth.login_with_email_and_password(user, password)
	%StateLabel.text = "Logging in"

func _on_sing_up_button_pressed():
	var password = $VBoxContainer/PasswordEdit.text
	var user = $VBoxContainer/UserEdit.text
	
	Firebase.Auth.signup_with_email_and_password(user, password)
	%StateLabel.text = "Signing Up"

func on_login_succeeded(auth):
	print(auth)
	%StateLabel.text = "Loggin Succeeded"
	Firebase.Auth.save_auth(auth)
	
func on_signup_succeeded(auth):
	print(auth)
	%StateLabel.text = "Signup Succeeded"
	Firebase.Auth.save_auth(auth)

func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	%StateLabel.text = "Logging failed. Error: %s" % message

	
func on_signup_failed(error_code, message):
		print(error_code)
		print(message)
		%StateLabel.text = "Signup failed. Error: %s" % message
