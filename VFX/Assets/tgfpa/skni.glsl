LIB(noise2D)

RANGE(1, 4)
uniform int octaves = 1;

RANGE(1, 5)
uniform float lacunarity = 2;

RANGE(0, 1)
uniform float persistance = 0.5;

RANGE(1, 10)
uniform float scale = 5;

RANGE(0, 1)
uniform float ridge = 0.1;

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.x;

    float amplitude = 1;
    float frequency = 1;
    float maxValue = 0;

    float value;
    for(int i = 0; i < octaves; i++) {
        value += snoise(uv * frequency * scale) * amplitude;
        maxValue += amplitude;

        frequency *= lacunarity;
        amplitude *= persistance;
    }

    value /= maxValue;
    value = value * 0.5 + 0.5;

    fragColor = vec4(value, value, value, 1.0);
}
