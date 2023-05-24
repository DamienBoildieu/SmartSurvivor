shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a > 0.5)
		COLOR.a = 0.6;
	//COLOR.a = 0.8;
	// Place fragment code here.
}
