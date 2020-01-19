// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Aslt/UI/CurvedEdge"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15

		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
		_Width("Width", Float) = 100
		_Height("Height", Float) = 100
		_EdgeSize("Edge Size", Float) = 10
		_EdgeBold("Edge Bold", Float) = 10
		_TextAreaColor("Text Area Color", Color) = (0,0,0,0)
		_EdgeColor("Edge Color", Color) = (0,0,0,0.6784314)

	}

	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }
		
		Stencil
		{
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			CompFront [_StencilComp]
			PassFront [_StencilOp]
			FailFront Keep
			ZFailFront Keep
			CompBack Always
			PassBack Keep
			FailBack Keep
			ZFailBack Keep
		}


		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		
		Pass
		{
			Name "Default"
		CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityUI.cginc"

			#pragma multi_compile __ UNITY_UI_CLIP_RECT
			#pragma multi_compile __ UNITY_UI_ALPHACLIP
			
			
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				half2 texcoord  : TEXCOORD0;
				float4 worldPosition : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform fixed4 _TextureSampleAdd;
			uniform float4 _ClipRect;
			uniform sampler2D _MainTex;
			uniform float4 _TextAreaColor;
			uniform float _Width;
			uniform float _Height;
			uniform float _EdgeSize;
			uniform float _EdgeBold;
			uniform float4 _EdgeColor;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID( IN );
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				OUT.worldPosition = IN.vertex;
				
				
				OUT.worldPosition.xyz +=  float3( 0, 0, 0 ) ;
				OUT.vertex = UnityObjectToClipPos(OUT.worldPosition);

				OUT.texcoord = IN.texcoord;
				
				OUT.color = IN.color * _Color;
				return OUT;
			}

			fixed4 frag(v2f IN  ) : SV_Target
			{
				float2 uv03 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float temp_output_10_0 = ( uv03.y / ( _Width / _Height ) );
				float2 appendResult14 = (float2(uv03.x , temp_output_10_0));
				float ifLocalVar139 = 0;
				if( _Width <= _Height )
				ifLocalVar139 = _Width;
				else
				ifLocalVar139 = _Height;
				float temp_output_141_0 = ( ifLocalVar139 / 2 );
				float ifLocalVar142 = 0;
				if( _EdgeSize <= temp_output_141_0 )
				ifLocalVar142 = _EdgeSize;
				else
				ifLocalVar142 = temp_output_141_0;
				float temp_output_16_0 = ( ifLocalVar142 / _Width );
				float2 appendResult17 = (float2(temp_output_16_0 , temp_output_16_0));
				float temp_output_13_0 = distance( appendResult14 , appendResult17 );
				float ifLocalVar143 = 0;
				if( _EdgeBold <= ifLocalVar142 )
				ifLocalVar143 = _EdgeBold;
				else
				ifLocalVar143 = ifLocalVar142;
				float temp_output_69_0 = ( ifLocalVar143 / _Width );
				float temp_output_68_0 = ( temp_output_16_0 - temp_output_69_0 );
				float temp_output_24_0 = ( 1.0 - temp_output_16_0 );
				float2 appendResult26 = (float2(temp_output_24_0 , temp_output_16_0));
				float temp_output_27_0 = distance( appendResult14 , appendResult26 );
				float temp_output_35_0 = ( _Height / _Width );
				float temp_output_31_0 = ( temp_output_35_0 - temp_output_16_0 );
				float2 appendResult32 = (float2(temp_output_16_0 , temp_output_31_0));
				float temp_output_33_0 = distance( appendResult14 , appendResult32 );
				float2 appendResult36 = (float2(temp_output_24_0 , temp_output_31_0));
				float temp_output_37_0 = distance( appendResult14 , appendResult36 );
				float temp_output_97_0 = ( temp_output_69_0 + temp_output_16_0 );
				float clampResult125 = clamp( ( ( step( temp_output_13_0 , temp_output_68_0 ) + step( temp_output_27_0 , temp_output_68_0 ) + step( temp_output_33_0 , temp_output_68_0 ) + step( temp_output_37_0 , temp_output_68_0 ) ) + ( ( ( step( uv03.x , ( temp_output_24_0 - temp_output_69_0 ) ) * step( temp_output_97_0 , uv03.x ) ) + ( step( temp_output_97_0 , temp_output_10_0 ) * step( temp_output_10_0 , ( temp_output_31_0 - temp_output_69_0 ) ) ) ) * ( step( uv03.x , ( 1.0 - temp_output_69_0 ) ) * step( temp_output_69_0 , uv03.x ) * step( temp_output_69_0 , temp_output_10_0 ) * step( temp_output_10_0 , ( temp_output_35_0 - temp_output_69_0 ) ) ) ) ) , 0.0 , 1.0 );
				float clampResult126 = clamp( ( ( step( temp_output_13_0 , temp_output_16_0 ) + step( temp_output_27_0 , temp_output_16_0 ) + step( temp_output_33_0 , temp_output_16_0 ) + step( temp_output_37_0 , temp_output_16_0 ) ) + ( ( step( uv03.x , temp_output_24_0 ) * step( temp_output_16_0 , uv03.x ) ) + ( step( temp_output_16_0 , temp_output_10_0 ) * step( temp_output_10_0 , temp_output_31_0 ) ) ) ) , 0.0 , 1.0 );
				
				half4 color = ( ( _TextAreaColor * clampResult125 ) + ( _EdgeColor * ( 1.0 - step( clampResult126 , clampResult125 ) ) ) );
				
				#ifdef UNITY_UI_CLIP_RECT
                color.a *= UnityGet2DClipping(IN.worldPosition.xy, _ClipRect);
                #endif
				
				#ifdef UNITY_UI_ALPHACLIP
				clip (color.a - 0.001);
				#endif

				return color;
			}
		ENDCG
		}
	}
}
/*ASEBEGIN
Version=17200
266;72;989;712;2436.355;-865.897;2.095725;True;False
Node;AmplifyShaderEditor.RangedFloatNode;8;-2807.082,804.83;Inherit;False;Property;_Height;Height;1;0;Create;True;0;0;False;0;100;120.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-2807.083,729.5703;Inherit;False;Property;_Width;Width;0;0;Create;True;0;0;False;0;100;301.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;139;-2579.672,814.1257;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;140;-2550.048,731.9958;Inherit;False;Constant;_Int0;Int 0;6;0;Create;True;0;0;False;0;2;0;0;1;INT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;141;-2386.426,733.6366;Inherit;False;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2801.037,642.9125;Inherit;False;Property;_EdgeSize;Edge Size;2;0;Create;True;0;0;False;0;10;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-2797.688,547.1603;Inherit;False;Property;_EdgeBold;Edge Bold;3;0;Create;True;0;0;False;0;10;3.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;142;-2230.229,628.5846;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;47;-2021.16,1017.128;Inherit;False;615.6818;304.6273;Get corrected Uv coordinate;4;3;9;10;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1786.081,736.0405;Inherit;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;143;-2057.439,494.1843;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;16;-1810.28,640.7914;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;35;-1774.167,862.4922;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1971.16,1067.128;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;31;-1572.624,862.0825;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;108;-1147.807,1366.402;Inherit;False;948.3282;880.101;Inner Text Area;18;97;89;94;106;85;82;105;84;83;87;86;99;100;98;101;88;102;107;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;69;-1848.085,500.4966;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;9;-1871.265,1189.555;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;24;-1574.866,739.4449;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;97;-1077.971,1564.399;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;10;-1707.443,1172.494;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;89;-1083.256,1436.182;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;94;-1068.632,1704.462;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;48;-1024.706,68.53556;Inherit;False;722.5657;746.0459;Edge;13;17;26;32;36;13;37;27;33;34;23;28;38;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;17;-974.7059,179.1872;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;51;-893.7111,845.4674;Inherit;False;515.0283;484.4122;Text Area;7;41;40;42;50;43;45;44;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StepOpNode;84;-845.0671,1718.614;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;83;-850.1895,1416.402;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-952.9107,682.3815;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;32;-963.0764,521.7805;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-968.9286,358.2557;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;105;-1097.807,1930.091;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1573.878,1116.97;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;82;-847.6282,1618.729;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;106;-1092.351,2057.62;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;85;-850.1898,1513.724;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;43;-841.1495,1097.795;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-717.0112,1452.257;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;101;-840.1651,2014.418;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;98;-842.7265,1812.091;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;99;-842.7268,1909.413;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-709.3282,1659.707;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;41;-843.7111,992.79;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;100;-837.604,2114.302;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;33;-817.5091,461.1291;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;45;-838.5884,1197.68;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;40;-843.7108,895.4674;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;27;-823.3615,297.6044;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;13;-829.1387,118.5356;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;68;-1673.798,503.9376;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;37;-807.3435,621.7302;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;-462.0071,-412.5932;Inherit;False;397.5055;473.874;Inner Edge;5;71;67;72;70;73;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StepOpNode;38;-635.7173,631.926;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;-539.9617,1514.075;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;34;-645.8823,471.3249;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;72;-412.0024,-168.8427;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;-677.093,1934.493;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;23;-669.7095,165.3242;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;67;-412.0071,-362.5933;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-710.5325,931.3226;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;70;-411.9975,-264.6697;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-702.8494,1138.773;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;28;-651.7348,307.8001;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;71;-411.9929,-70.91913;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;50;-533.4828,1004.7;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-370.2784,1685.194;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;73;-220.5017,-262.3343;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-458.1402,370.0114;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;17.85235,407.8577;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-158.46,564.4549;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;126;69.047,545.9901;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;125;205.1894,340.8688;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;136;250.5699,493.3486;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;111;-34.56694,803.5645;Inherit;False;Property;_EdgeColor;Edge Color;5;0;Create;True;0;0;False;0;0,0,0,0.6784314;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;137;384.8972,502.425;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;109;34.65145,64.94732;Inherit;False;Property;_TextAreaColor;Text Area Color;4;0;Create;True;0;0;False;0;0,0,0,0;0.6981132,0.6981132,0.6981132,0.6705883;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;587.3585,577.1595;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;421.202,231.955;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;138;884.0867,413.4783;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2;1192.842,534.5591;Float;False;True;2;ASEMaterialInspector;0;4;Aslt/UI/CurvedEdge;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;True;2;False;-1;True;True;True;True;True;0;True;-9;True;True;0;True;-5;255;True;-8;255;True;-7;0;True;-4;0;True;-6;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;0;True;-11;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;0
WireConnection;139;0;7;0
WireConnection;139;1;8;0
WireConnection;139;2;8;0
WireConnection;139;3;7;0
WireConnection;139;4;7;0
WireConnection;141;0;139;0
WireConnection;141;1;140;0
WireConnection;142;0;11;0
WireConnection;142;1;141;0
WireConnection;142;2;141;0
WireConnection;142;3;11;0
WireConnection;142;4;11;0
WireConnection;143;0;65;0
WireConnection;143;1;142;0
WireConnection;143;2;142;0
WireConnection;143;3;65;0
WireConnection;143;4;65;0
WireConnection;16;0;142;0
WireConnection;16;1;7;0
WireConnection;35;0;8;0
WireConnection;35;1;7;0
WireConnection;31;0;35;0
WireConnection;31;1;16;0
WireConnection;69;0;143;0
WireConnection;69;1;7;0
WireConnection;9;0;7;0
WireConnection;9;1;8;0
WireConnection;24;0;30;0
WireConnection;24;1;16;0
WireConnection;97;0;69;0
WireConnection;97;1;16;0
WireConnection;10;0;3;2
WireConnection;10;1;9;0
WireConnection;89;0;24;0
WireConnection;89;1;69;0
WireConnection;94;0;31;0
WireConnection;94;1;69;0
WireConnection;17;0;16;0
WireConnection;17;1;16;0
WireConnection;84;0;10;0
WireConnection;84;1;94;0
WireConnection;83;0;3;1
WireConnection;83;1;89;0
WireConnection;36;0;24;0
WireConnection;36;1;31;0
WireConnection;32;0;16;0
WireConnection;32;1;31;0
WireConnection;26;0;24;0
WireConnection;26;1;16;0
WireConnection;105;0;30;0
WireConnection;105;1;69;0
WireConnection;14;0;3;1
WireConnection;14;1;10;0
WireConnection;82;0;97;0
WireConnection;82;1;10;0
WireConnection;106;0;35;0
WireConnection;106;1;69;0
WireConnection;85;0;97;0
WireConnection;85;1;3;1
WireConnection;43;0;16;0
WireConnection;43;1;10;0
WireConnection;86;0;83;0
WireConnection;86;1;85;0
WireConnection;101;0;69;0
WireConnection;101;1;10;0
WireConnection;98;0;3;1
WireConnection;98;1;105;0
WireConnection;99;0;69;0
WireConnection;99;1;3;1
WireConnection;87;0;82;0
WireConnection;87;1;84;0
WireConnection;41;0;16;0
WireConnection;41;1;3;1
WireConnection;100;0;10;0
WireConnection;100;1;106;0
WireConnection;33;0;14;0
WireConnection;33;1;32;0
WireConnection;45;0;10;0
WireConnection;45;1;31;0
WireConnection;40;0;3;1
WireConnection;40;1;24;0
WireConnection;27;0;14;0
WireConnection;27;1;26;0
WireConnection;13;0;14;0
WireConnection;13;1;17;0
WireConnection;68;0;16;0
WireConnection;68;1;69;0
WireConnection;37;0;14;0
WireConnection;37;1;36;0
WireConnection;38;0;37;0
WireConnection;38;1;16;0
WireConnection;88;0;86;0
WireConnection;88;1;87;0
WireConnection;34;0;33;0
WireConnection;34;1;16;0
WireConnection;72;0;33;0
WireConnection;72;1;68;0
WireConnection;102;0;98;0
WireConnection;102;1;99;0
WireConnection;102;2;101;0
WireConnection;102;3;100;0
WireConnection;23;0;13;0
WireConnection;23;1;16;0
WireConnection;67;0;13;0
WireConnection;67;1;68;0
WireConnection;42;0;40;0
WireConnection;42;1;41;0
WireConnection;70;0;27;0
WireConnection;70;1;68;0
WireConnection;44;0;43;0
WireConnection;44;1;45;0
WireConnection;28;0;27;0
WireConnection;28;1;16;0
WireConnection;71;0;37;0
WireConnection;71;1;68;0
WireConnection;50;0;42;0
WireConnection;50;1;44;0
WireConnection;107;0;88;0
WireConnection;107;1;102;0
WireConnection;73;0;67;0
WireConnection;73;1;70;0
WireConnection;73;2;72;0
WireConnection;73;3;71;0
WireConnection;29;0;23;0
WireConnection;29;1;28;0
WireConnection;29;2;34;0
WireConnection;29;3;38;0
WireConnection;95;0;73;0
WireConnection;95;1;107;0
WireConnection;46;0;29;0
WireConnection;46;1;50;0
WireConnection;126;0;46;0
WireConnection;125;0;95;0
WireConnection;136;0;126;0
WireConnection;136;1;125;0
WireConnection;137;0;136;0
WireConnection;112;0;111;0
WireConnection;112;1;137;0
WireConnection;128;0;109;0
WireConnection;128;1;125;0
WireConnection;138;0;128;0
WireConnection;138;1;112;0
WireConnection;2;0;138;0
ASEEND*/
//CHKSM=A604E4322E0409086EE596440179C8F0B9FED7EF