Shader "Mine/Element"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
                float4 color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
                float4 color : COLOR;
            };

            uniform float showWhite;
            uniform float vertColor;
            uniform float normals;
            uniform float normalizedNormals;
            uniform float uv;
            uniform float tex;

            sampler2D _MainTex;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.color = v.color;
                o.normal = v.normal;

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                half3 color = half3(1,1,1) * showWhite;
                color += i.color * vertColor;
                color += i.normal * normals;
                color += (i.normal * 0.5 + 0.5) * normalizedNormals;
                color += half3(i.uv * uv, 0);
                color += tex2D(_MainTex, i.uv).rgb * tex;

                return half4(color, 1);
            }
            ENDCG
        }
    }
}
