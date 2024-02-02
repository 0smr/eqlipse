#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float u_value;
    float height;
    float width;
    vec4 u_color;
    vec4 u_accent;
    vec4 u_border;
    vec4 u_radius;
    float u_strokwidth;
    float u_blend;
};

float mpx = min(1/width, 1/height);
vec2 ratio = vec2(width, height)/max(width, height);

float sdRoundBox(vec2 region, vec2 pos, vec2 b, vec4 r) {
    r.xy = mix(r.xy, r.wz, region.y);
    r.x  = mix(r.x, r.y, region.x);
    vec2 q = abs(pos) - b + r.x;
    return clamp(q.x, q.y, 0.0) + length(max(q, 0.0)) - r.x;
}

void main() {
    vec2 uv = qt_TexCoord0, pos = (uv - 0.5) * ratio;
    float a = u_value * 3.141592,
          d = smoothstep(0, 2.0 * u_blend, abs(dot(pos, vec2(sin(a), cos(a))))),
          mhr = min(ratio.x, ratio.y)/2,
          sw = u_strokwidth * mpx/2,
          rect = sdRoundBox(round(uv), pos, ratio/2, min(u_radius * mpx, mhr));
    vec2 vfb = smoothstep(vec2(0.1 * mpx), vec2(0), vec2(rect + mpx * 0.1, abs(rect + sw) - sw));
    vec4 bcolor = mix(u_accent, u_border, d);
    fragColor = vfb.x * mix(u_color, bcolor, vfb.y) * qt_Opacity;
}

