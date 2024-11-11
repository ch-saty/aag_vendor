#version 460 core

precision highp float;

uniform vec2 uSize;
uniform float uTime;
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
    vec2 uv = gl_FragCoord.xy / uSize;
    float aspectRatio = uSize.x / uSize.y;
    
    // Calculate wave
    float wave = sin(uv.x * 4.0 * 3.14159 + uTime * 2.0 * 3.14159) * 0.05;
    
    // Adjust wave based on y-coordinate to create tilt
    wave *= mix(1.0, 0.5, uv.y);
    
    // Add tilt
    float tilt = mix(1.0, 0.7, uv.x);
    float threshold = tilt - wave;
    
    if (uv.y > threshold) {
        // Apply blur effect
        vec2 pixelSize = 1.0 / uSize;
        float blur = (uv.y - threshold) * 20.0;
        vec4 sum = vec4(0.0);
        for (float y = -4.0; y <= 4.0; y += 1.0) {
            for (float x = -4.0; x <= 4.0; x += 1.0) {
                vec2 offset = vec2(x, y) * pixelSize * blur;
                sum += texture(uTexture, uv + offset);
            }
        }
        fragColor = sum / 81.0;
    } else {
        fragColor = texture(uTexture, uv);
    }
}