@tool
extends MeshInstance3D

var visual_shader : VisualShader
var number_of_parameters : int = 0
var properties = []

# cant add dynamic descriptions until this is pushed in godot: https://github.com/godotengine/godot/pull/115182

func _enter_tree() -> void:
	visual_shader = (get_active_material(0) as ShaderMaterial).shader as VisualShader

func property_item(parameter : VisualShaderNodeParameter) -> Dictionary:
	var hint : PropertyHint
	var index = 0
	for i in range(ShaderParameter.SHADER_PARAMETERS.size()):
		var index_parameter : ShaderParameter = ShaderParameter.SHADER_PARAMETERS[i]
		if is_instance_of(parameter, index_parameter.TYPE):
			index = i
			break

	#print("PlaceHolderTexture.gd // property_item() // i, type, base type, hint: ", 
	#index, " ", ShaderParameter.SHADER_PARAMETERS[index].TYPE, " ", ShaderParameter.SHADER_PARAMETERS[index].BASE_TYPE, " ", ShaderParameter.SHADER_PARAMETERS[index].HINT)
	return {
		"name" : parameter.parameter_name,
		"type" : ShaderParameter.SHADER_PARAMETERS[index].BASE_TYPE,
		"hint" : ShaderParameter.SHADER_PARAMETERS[index].HINT,
		"hint_string" : ShaderParameter.SHADER_PARAMETERS[index].HINT_STRING
	}

func _get_property_list():
	ShaderParameter.init_consts()
	var node_parameters : Array[VisualShaderNodeParameter] = []
	for i in range(VisualShader.TYPE_MAX):
		var node_list := visual_shader.get_node_list(i)
		for node_id in node_list:
			#print("PlaceholderTexture.gd // _ready() // Getting node ", node_id, " of ", i)
			var node := visual_shader.get_node(i, node_id)
			if node is VisualShaderNodeParameter:
				var parameter_node : VisualShaderNodeParameter = node
				node_parameters.append(parameter_node)
	number_of_parameters = node_parameters.size()

	properties = []

	for parameter in node_parameters:
		#(get_active_material(0) as ShaderMaterial).set_shader_parameter(parameter.parameter_name, )
		properties.append(property_item(parameter))

	return properties

func _get(property):
	for placeholder_property : Dictionary in properties:
		if (placeholder_property["name"] == property):
			return (get_active_material(0) as ShaderMaterial).get_shader_parameter(property)
	#print("PlaceHolderTexture.gd // _get() // ", property)
	#return (get_active_material(0) as ShaderMaterial).get_shader_parameter(parameter.parameter_name)

func _set(property, value):
	for placeholder_property : Dictionary in properties:
		if (placeholder_property["name"] == property):
			(get_active_material(0) as ShaderMaterial).set_shader_parameter(property, value)
			return true
	return false
