Shader "Unlit/BarrierClean"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _DistTex ("Texture", 2D) = "white" {}

        [HDR] _Color("Color", Color) = (1,1,1,1)

        _DistStr("Distortion Str", Range(0.1, 1)) = 1
        _ScrollSpeedX("Scroll speed X", Range(0.1, 5)) = 1
        _ScrollSpeedY("Scroll speed Y", Range(0.1, 5)) = 1

        _frasnel("Frasnel", Range(0.1, 1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "RenderQueue" = "Transparent" "IgnoreProjector"="True"}

        Blend One One
        ZWrite Off
        Cull Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
                float3 viewDir : TEXCOORD1;
            };

            sampler2D _MainTex;
            sampler2D _DistTex;

            float _ScrollSpeedX;
            float _ScrollSpeedY;

            float _DistStr;

            float4 _Color;
            float _frasnel;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.normal = UnityObjectToWorldNormal(v.normal);

                float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.viewDir = normalize(UnityWorldSpaceViewDir(worldPos));

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float ndotv = 1 - saturate(dot(i.normal, i.viewDir));


                float dist = tex2D(_DistTex, i.uv).r * _DistStr;
                float2 uv = i.uv + float2(_Time.x * _ScrollSpeedX + dist, _Time.x * _ScrollSpeedY + dist);

                fixed4 col = tex2D(_MainTex, uv);

                col *= col * col;
                col *= _Color;

                col *= ndotv * ndotv;

                // frasnel
                float frasnel = dot(i.normal, i.viewDir);
                col += _Color * (1 - saturate(pow(frasnel, _frasnel)));

                return col;
            }
            ENDCG
        }
    }
}
