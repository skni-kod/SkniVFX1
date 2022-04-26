LIB(noise2D)

RANGE(1, 4)
uniform int octaves = 2;

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
        value += ridge - abs(snoise(uv * frequency * scale) * amplitude);
        maxValue += amplitude;

        frequency *= lacunarity;
        amplitude *= persistance;
    }

    float d = snoise(uv * scale + value + iTime * 0.3) * 0.5 + 0.5;

    fragColor = vec4(d, d, d , 1.0);
}
