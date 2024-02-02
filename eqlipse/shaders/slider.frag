#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float u_en;
    float u_value;
    float height;
    float width;
    vec4 u_color;
    vec4 u_accent;
};

float step = 5;
float tickwidth = 0.8;

float wpx = 1/width;
vec2 size = vec2(width, height);
vec2 ratio = vec2(width, height)/height;

void main() {
    float twidth = tickwidth/step;
    vec2 uv = qt_TexCoord0;
    float val = uv.x - u_value;
    vec2 coord = qt_TexCoord0 * size;
    float wave = smoothstep(25 * wpx, 0.0, abs(val)) ;
    float theight = smoothstep(0.0, 0.05/size.y, 0.25 - abs(1.0 - qt_TexCoord0.y - 0.25 - wave * 0.49 * u_en));
    float tick = smoothstep(0.0, 0.5/step, twidth - abs(fract(coord.x / step) - twidth)) * theight;
    vec4 _color = mix(u_accent, u_color, smoothstep(0.0, wpx, val - wpx/2));
    fragColor = _color * qt_Opacity * tick;
}
