shader_type canvas_item;

uniform vec2 tiled_factor = vec2(1.0, 1.0);
uniform float speed = 1.0;
uniform float max_wave_strength = 0.5;

float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    vec2 tiled_uvs = UV * tiled_factor;

    // Identify the current tile
    vec2 tile_id = floor(tiled_uvs);

    // Generate separate random wave strengths for x and y
    float rand_x = rand(tile_id + vec2(1.0, 0.0));
    float rand_y = rand(tile_id + vec2(0.0, 1.0));

    float wave_strength_x = rand_x * max_wave_strength;
    float wave_strength_y = rand_y * max_wave_strength;

    float time_phase = TIME * speed;

    vec2 waves_uv_offset;
    waves_uv_offset.x = cos(time_phase) * wave_strength_x;
    waves_uv_offset.y = sin(time_phase) * wave_strength_y;

    COLOR = texture(TEXTURE, tiled_uvs + waves_uv_offset * 0.5);
}