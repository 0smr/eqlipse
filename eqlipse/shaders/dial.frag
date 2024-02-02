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

float px = 1/height;
vec2 ratio = vec2(width, height)/height;
vec2 angles = vec2(-140, 140) * 0.01745;

mat2 rot(float a) { return mat2(cos(a), -sin(a), sin(a), cos(a)); }
float sdVCapsule(vec2 p, float h, float r) {
    p.y -= clamp(p.y + h/2, 0.0, h) - h/2;
    return length(p) - r;
}

void main() {
    vec2 uv = (qt_TexCoord0 - 0.5) * ratio;

    float n = 55, sec = 6.283185/n, range = abs(angles.x - angles.y)/6.283185;
    uv *= rot(-angles.x);
    float a = round(atan(uv.x, uv.y)/sec) * sec,
          aid = -a / 6.283185 + 0.5,
          v = aid - u_value * range,
          wave = smoothstep(.05, 0, abs(v)) * u_en,
          cursor = smoothstep(5 * px, 0, v + px/2);

    // Rotate each ticks
    uv *= rot(a);
    // Wave displacement
    uv.y -= 0.5 + wave * 10 * px - 10 * px - 8 * px;

    float ticks = mix(sdVCapsule(uv, mix(px/4, 8 * px, cursor), px/4), 9999, step(range, aid));
    vec4 color = mix(u_color, u_accent, cursor);
    fragColor = color * smoothstep(px/2, 0.0, ticks) * qt_Opacity;
}

