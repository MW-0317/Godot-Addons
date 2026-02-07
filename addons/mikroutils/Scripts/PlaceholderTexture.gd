@tool
extends MeshInstance3D

var visual_shader : VisualShader

# cant add dynamic descriptions until this is pushed in godot: https://github.com/godotengine/godot/pull/115182

func _enter_tree() -> void:
	visual_shader = (get_active_material(0) as ShaderMaterial).shader as VisualShader

func property_item(parameter : VisualShaderNodeParameter) -> Dictionary:
	var shader_parameters : Array[ShaderParameter] = [
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
	
	var hint : PropertyHint
	var index = 0
	for i in range(shader_parameters.size()):
		var index_parameter : ShaderParameter = shader_parameters[i]
		if is_instance_of(parameter, index_parameter.TYPE):
			index = i
			break

	print("PlaceHolderTexture.gd // property_item() // i, type, base type, hint: ", 
	index, " ", shader_parameters[index].TYPE, " ", shader_parameters[index].BASE_TYPE, " ", shader_parameters[index].HINT)
	return {
		"name" : parameter.parameter_name,
		"type" : shader_parameters[index].BASE_TYPE,
		"hint" : shader_parameters[index].HINT,
		"hint_string" : shader_parameters[index].HINT_STRING
	}

func _get_property_list():
	var node_parameters : Array[VisualShaderNodeParameter] = []


	for i in range(VisualShader.TYPE_MAX):
		var node_list := visual_shader.get_node_list(i)
		for node_id in node_list:
			print("PlaceholderTexture.gd // _ready() // Getting node ", node_id, " of ", i)
			var node := visual_shader.get_node(i, node_id)
			if node is VisualShaderNodeParameter:
				var parameter_node : VisualShaderNodeParameter = node
				node_parameters.append(parameter_node)

	var properties = []

	for parameter in node_parameters:
		properties.append(property_item(parameter))

	return properties
	
