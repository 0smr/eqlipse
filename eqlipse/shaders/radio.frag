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

vec2 size = vec2(width, height);
vec2 ratio = vec2(width, height)/height;

void main() {
    vec2 uv = qt_TexCoord0;

    fragColor = u_color;
}
