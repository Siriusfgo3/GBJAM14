shader_type canvas_item;

uniform vec4 darkest : source_color;
uniform vec4 dark : source_color;
uniform vec4 light : source_color;
uniform vec4 lightest : source_color;

void fragment() {
    vec4 current_pixel = texture(TEXTURE, UV); 

    float brightness = dot(
        current_pixel.rgb,
        vec3(0.299, 0.587, 0.114) /* Traditional so called Luma weights for perceived brightness */
    );

    if (brightness < 0.25) {
        COLOR = darkest;
    }
    else if (brightness < 0.50) {
        COLOR = dark;
    }
    else if (brightness < 0.75) {
        COLOR = light;
    }
    else {
        COLOR = lightest;
    }
}