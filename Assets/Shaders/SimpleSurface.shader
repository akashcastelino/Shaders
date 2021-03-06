﻿Shader "Tutorial/SimpleSurface"
{
	Properties
	{
		_Color("Tint", Color) = (0,0,0,0)
		_MainTex("Texture", 2D) = "white" {}
		_Smoothness("Smoothness", Range(0,1)) = 0
		_Metallic("Metallic", Range(0,1)) = 0
		[HDR] _Emission("Emission", Color) = (0,0,0,1)
	}

		SubShader
	{
		Tags{"RenderType" = "Opaque" "Queue" = "Geometry"}

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		fixed4 _Color;
		sampler2D _MainTex;
		half _Smoothness;
		half _Metallic;
		half3 _Emission;
		
		
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input i, inout SurfaceOutputStandard o) {
			fixed4 col = tex2D(_MainTex, i.uv_MainTex);
			col *= _Color;
			o.Albedo = col.rgb;
			o.Smoothness = _Smoothness;
			o.Metallic = _Metallic;
			o.Emission = _Emission;
		}
		

		ENDCG
	}
	Fallback "Standard"
	
}