Shader "Unlit/NotClean"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RampTex ("RampTexture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _RampTex;

            v2f vert (appdata v)
            {
                v2f o;
                // v.vertex.xyz += v.normal * sin(_Time.y) * 0.1;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                o.normal = UnityObjectToWorldNormal(v.normal);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float ndotl = dot(_WorldSpaceLightPos0, i.normal) * 0.5 + 0.5;
                float ramp = tex2D(_RampTex, float2(ndotl, 0)).r;
                fixed4 col = tex2D(_MainTex, i.uv) * saturate(ramp + 0.1);

                return col;
            }
            ENDCG
        }
    }
}
