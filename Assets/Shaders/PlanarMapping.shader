Shader "Tutorial/PlanarMapping"
{
	Properties
	{
		_Color("Tint", Color) = (0,0,0,0)
		_MainTex("Texture", 2D) = "white" {}
	}

		SubShader
	{
		Tags{"RenderQueue" = "Opaque" "Queue" = "Geometry"}

		Pass
		{
			CGPROGRAM

			#include "UnityCG.cginc"
			#pragma vertex vert
			#pragma fragment frag

			fixed4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;

			struct appdata
			{
				float4 position : POSITION;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			v2f vert(appdata v)
			{
				v2f o;
				o.position = UnityObjectToClipPos(v.position);
				float4 worldPos = mul(unity_ObjectToWorld, v.position);
				o.uv = TRANSFORM_TEX(worldPos.xy, _MainTex);
				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= _Color;
				return col;
			}

			ENDCG
		}
	}
}
