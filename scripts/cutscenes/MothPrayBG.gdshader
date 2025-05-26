shader_type canvas_item;

uniform vec2 tiled_factor = vec2(1.0,1.0);

void fragment() {
	vec2 tiled_uvs = UV * tiled_factor;
	
	vec2 waves_uv_offset;
	waves_uv_offset.x = cos(TIME) * 0.05;
	waves_uv_offset.y = sin(TIME) * 0.05;
	
	COLOR = texture(TEXTURE,tiled_uvs + waves_uv_offset * 0.5);
}