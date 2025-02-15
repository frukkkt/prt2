@tool
class_name BuildCardInStorage
extends Card


func set_name_build():
	super.set_name_build()
	if disabled:
		text = "???????"
