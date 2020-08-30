Shader "Tutorial/ColorInterpolationTextureByTexture"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_SecondaryTex("Secondary Texture", 2D) = "black" {}
		_BlendTex("Blend Texture", 2D) = "grey" {}
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }

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
				};

				struct v2f
				{
					float2 uv : TEXCOORD0;
					float4 vertex : SV_POSITION;
				};

				//the colors to blend between
				sampler2D _MainTex;
				float4 _MainTex_ST;

				sampler2D _SecondaryTex;
				float4 _SecondaryTex_ST;
				

				sampler2D _BlendTex;
				float4 _BlendTex_ST;


				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = v.uv;

					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{

					float2 main_uv = TRANSFORM_TEX(i.uv, _MainTex);
					float2 secondary_uv = TRANSFORM_TEX(i.uv, _SecondaryTex);
					float2 blend_uv = TRANSFORM_TEX(i.uv, _BlendTex);

					float4 main_color = tex2D(_MainTex, main_uv);
					float4 secondary_color = tex2D(_SecondaryTex, secondary_uv);
					float4 blend_color = tex2D(_BlendTex, blend_uv);
					float blend_value = blend_color.r;
					fixed4 col = lerp(main_color, secondary_color, blend_value);

					return col;
				}
				ENDCG
			}
		}
}
