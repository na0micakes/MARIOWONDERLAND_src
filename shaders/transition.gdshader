shader_type canvas_item;
render_mode unshaded;

uniform sampler2D hole_texture;
uniform float screen_width;
uniform float screen_height;
uniform float scale :hint_range(0.0, 100.0, 0.01);

void fragment() {
	float ratio = screen_width / screen_height;
	vec2 custom_uv = (UV - vec2(0.5)) * scale + vec2(0.5);
	vec4 textura = texture(hole_texture,custom_uv);
	float dist = distance(vec2(0.5, 0.5), vec2(mix(0.5, UV.x, ratio), UV.y));
	if (scale < 95.0){
		COLOR.a = step(textura.a, dist);
	}
}