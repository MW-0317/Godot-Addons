class_name ShaderParameter
extends Resource

var BASE_TYPE
var TYPE
var HINT : int
var HINT_STRING : String

func _init(p_BASE_TYPE, p_TYPE, p_HINT : int, p_HINT_STRING : String):
	BASE_TYPE = p_BASE_TYPE
	TYPE = p_TYPE
	HINT = p_HINT
	HINT_STRING = p_HINT_STRING
