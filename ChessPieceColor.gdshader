shader_type canvas_item;

uniform vec4 whiteColor : source_color = vec4(0.90f, 0.89f, 0.78f, 1.0f); // Eggshell-y 
uniform vec4 blackColor : source_color = vec4(0.16f, 0.14f, 0.13f, 1.0f); // Ivory-y
uniform bool isWhite = true;

void fragment() {
	COLOR = mix(blackColor, whiteColor, float(isWhite)) * COLOR.a;
	
	vec4 blurred_col = texture(TEXTURE, UV, 2.0f);
	if (blurred_col.a > 0.0f && blurred_col.a < 1.0f) {
		COLOR.rgb = vec3(1.0f, 0.0f, 0.0f);
	}
}
