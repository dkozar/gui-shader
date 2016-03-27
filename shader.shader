// GUI shader
// Copyright Danko Kozar 2013

Shader "eDriven/GUI Shader" {
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        //_BumpMap ("Bumpmap", 2D) = "bump" {}
        _XMin ("Start Point", Range(0, 1)) = 0
        _XMax ("End Point", Range(0, 1))= 1
        _YMin ("Start Point", Range(0, 1)) = 0
        _YMax ("End Point", Range(0, 1))= 1
    }
    SubShader {
        Tags { "RenderType" = "Opaque" }
        Cull Off
        Lighting Off

        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float2 uv_MainTex;
            //float2 uv_BumpMap;
            float3 worldPos;
            float4 screenPos;
        };

        sampler2D _MainTex;
        //sampler2D _BumpMap;
        float _XMin;
        float _XMax;
        float _YMin;
        float _YMax;

        void surf (Input IN, inout SurfaceOutput o) {
            clip (IN.screenPos.x - _XMin);
            clip (_XMax - IN.screenPos.x);
            clip (IN.screenPos.y - _YMin);
            clip (_YMax - IN.screenPos.y);
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
            //o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
        }
        ENDCG
    }
    Fallback "Diffuse"
}