shader_type canvas_item;

uniform float threshold;
uniform vec3 edges_color;

vec2 compute_gradients(vec4 center, vec4 left, vec4 right, vec4 top, vec4 bottom, vec2 steps) {
	vec4 grad_x = ((center - left)/steps.x + (center - right)/steps.x)/2.;
	vec4 grad_y = ((center - top)/steps.y + (center - bottom)/steps.y)/2.;
	return vec2(length(grad_x), length(grad_y));
}

void fragment() {
	vec2 steps = vec2(float(textureSize(TEXTURE, 0).x), float(textureSize(TEXTURE, 0).y));
	steps = 1./steps;
	vec4 pix_color = texture(TEXTURE, UV);
	
	vec2 pos_l = UV;
	if (pos_l.x > 0.)
		pos_l.x -= steps.x;
	vec4 col_l = texture(TEXTURE, pos_l);
	
	vec2 pos_r = UV;
	if (pos_r.x < float(textureSize(TEXTURE, 0).x)-steps.x)
		pos_r.x += steps.x;
	vec4 col_r = texture(TEXTURE, pos_r);
	
	vec2 pos_t = UV;
	if (pos_t.y > 0.)
		pos_t.y -= steps.y;
	vec4 col_t = texture(TEXTURE, pos_t);
	
	vec2 pos_b = UV;
	if (pos_b.y < float(textureSize(TEXTURE, 0).y)-steps.y)
		pos_b.y += steps.y;
	vec4 col_b = texture(TEXTURE, pos_b);
	
	vec2 grad_length = compute_gradients(pix_color, col_l, col_r, col_t, col_b, steps);
	if (length(grad_length)> threshold)
		COLOR = vec4(edges_color, pix_color.a);
	else
		COLOR = vec4(0.);
}
