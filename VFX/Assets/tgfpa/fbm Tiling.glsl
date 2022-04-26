LIB(psrdnoise2D)

RANGE(1, 4)
uniform int octaves = 2;

RANGE(1, 5)
uniform int lacunarity = 2;

RANGE(0, 1)
uniform float persistance = 0.5;

RANGE(1, 10)
uniform int scale = 5;

RANGE(0, 1)
uniform float ridge = 0.1;

RANGE(0, 10)
uniform vec2 offset;

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.x;

    float amplitude = 1;
    float frequency = 1;
    float maxValue = 0;

    float value;
    for(int i = 0; i < octaves; i++) {
        value += psnoise(uv * frequency * scale + offset, vec2(scale, scale)) * amplitude;
        maxValue += amplitude;

        frequency *= lacunarity;
        amplitude *= persistance;
    }

    value /= maxValue;
    value = value * 0.5 + 0.5;

    fragColor = vec4(value, value, value, 1.0);
}
