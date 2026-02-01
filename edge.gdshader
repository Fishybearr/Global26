shader_type canvas_item;

uniform vec4 ant_color_1: source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 ant_color_2: source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float ant_width = 2.0;
uniform float ant_length = 10.0;
uniform float ant_speed = 30.0;

void fragment() {
	if (texture(TEXTURE, UV).a > 0.0) {
		COLOR = texture(TEXTURE, UV);
	} else {
		// Initialize alpha to maximum
		float maxAlpha = 0.0;
		
		bool greater = false;
		// Sample a grid around the pixel based on the defined radius to find the minimum alpha
	    for (int x = -1; x <= 1; x++) {
	        for (int y = -1; y <= 1; y++) {
	            float sampleAlpha = texture(TEXTURE, ((UV * (vec2(272, 272))) + vec2(float(x), float(y))) / vec2(272, 272)).a;
				maxAlpha = max(maxAlpha, sampleAlpha);
	        }
		}

	    if (maxAlpha > 0.0) {
			float speed = TIME * .125;
			float stripe = step(.1, sin((UV.x + UV.y + speed) * 200.0));
			COLOR = vec4(vec3(stripe), 1.0);
		}
	
	}
	
}