class_name ShaderParameter
extends Resource

var BASE_TYPE
var TYPE
var HINT : int
var HINT_STRING : String

static var SHADER_PARAMETERS : Array[ShaderParameter]

func _init(p_BASE_TYPE, p_TYPE, p_HINT : int, p_HINT_STRING : String):
	BASE_TYPE = p_BASE_TYPE
	TYPE = p_TYPE
	HINT = p_HINT
	HINT_STRING = p_HINT_STRING
	
static func init_consts():
	SHADER_PARAMETERS = [
		# Boolean
		ShaderParameter.new(
			TYPE_BOOL,
			VisualShaderNodeBooleanParameter,
			0,
			""
		),
		# Int
		ShaderParameter.new(
			TYPE_INT,
			VisualShaderNodeIntParameter,
			0,
			""
		),
		ShaderParameter.new(
			TYPE_INT,
			VisualShaderNodeUIntParameter,
			0,
			""
		),
		ShaderParameter.new(
			TYPE_FLOAT,
			VisualShaderNodeFloatParameter,
			0,
			""
		),
		ShaderParameter.new(
			TYPE_VECTOR2,
			VisualShaderNodeVec2Parameter,
			0,
			""
		),
		ShaderParameter.new(
			TYPE_VECTOR3,
			VisualShaderNodeVec3Parameter,
			0,
			""
		),
		ShaderParameter.new(
			TYPE_VECTOR4,
			VisualShaderNodeVec4Parameter,
			0,
			""
		),
		ShaderParameter.new(
			TYPE_COLOR,
			VisualShaderNodeColorParameter,
			0,
			""
		),
		ShaderParameter.new(
			TYPE_TRANSFORM3D,
			VisualShaderNodeTransformParameter,
			0,
			""
		),
		ShaderParameter.new(
			TYPE_OBJECT,
			VisualShaderNodeTexture2DParameter,
			PROPERTY_HINT_RESOURCE_TYPE,
			"Texture2D"
		),
		ShaderParameter.new(
			TYPE_OBJECT,
			VisualShaderNodeTexture3DParameter,
			PROPERTY_HINT_RESOURCE_TYPE,
			"Texture3D"
		),
		ShaderParameter.new(
			TYPE_OBJECT,
			VisualShaderNodeTexture2DArrayParameter,
			PROPERTY_HINT_RESOURCE_TYPE,
			"Texture2DArray"
		),
		ShaderParameter.new(
			TYPE_OBJECT,
			VisualShaderNodeCubemapParameter,
			PROPERTY_HINT_RESOURCE_TYPE,
			"Cubemap"
		),
	]
