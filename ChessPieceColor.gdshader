shader_type canvas_item;

uniform vec4 whiteColor : source_color = vec4(0.90f, 0.89f, 0.78f, 1.0f); // Eggshell-y 
uniform vec4 blackColor : source_color = vec4(0.16f, 0.14f, 0.13f, 1.0f); // Ivory-y
uniform vec4 selected_color : source_color = vec4(1.0f, 0.0f, 0.0f, 1.0f);
uniform sampler2D blurryVersion;
uniform bool isWhite = true;
uniform bool selected = false;
uniform float intensity = 3.0f;

void fragment() {
	
	// Change the piece color
	vec4 blur_color = texture(blurryVersion, UV);
	COLOR = mix(blackColor, whiteColor, float(isWhite)) * COLOR.a;
	
	// Add the glow if the piece is selected
	if (selected && COLOR.a < 1.0f && blur_color.a < 1.0f && blur_color.a > 0.0f) {
		COLOR = vec4(selected_color.rgb, blur_color.a * intensity);
	}
	
}
