package lime.text;


import haxe.io.Bytes;
import lime._backend.native.NativeCFFI;
import lime.math.Vector2;
import lime.system.System;
import lime.text.harfbuzz.HBBuffer;
import lime.text.harfbuzz.HBDirection;
import lime.text.harfbuzz.HBFTFont;
import lime.text.harfbuzz.HBLanguage;
import lime.text.harfbuzz.HBScript;
import lime.text.harfbuzz.HB;

#if !lime_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end

@:access(lime._backend.native.NativeCFFI)
@:access(lime.text.Font)


class TextLayout {
	
	
	public var direction (get, set):TextDirection;
	public var font (default, set):Font;
	public var glyphs (get, null):Array<Glyph>;
	public var language (get, set):String;
	 @:isVar public var positions (get, null):Array<GlyphPosition>;
	public var script (get, set):TextScript;
	public var size (default, set):Int;
	public var text (default, set):String;
	
	private var __dirty:Bool;
	
	@:noCompletion private var __buffer:HBBuffer;
	//@:noCompletion private var __buffer:Bytes;
	@:noCompletion private var __direction:TextDirection;
	//@:noCompletion private var __handle:Dynamic;
	@:noCompletion private var __language:String;
	@:noCompletion private var __script:TextScript;
	
	
	public function new (text:String = "", font:Font = null, size:Int = 12, direction:TextDirection = LEFT_TO_RIGHT, script:TextScript = COMMON, language:String = "en") {
		
		this.text = text;
		this.font = font;
		this.size = size;
		
		__direction = direction;
		__script = script;
		__language = language;
		
		positions = [];
		__dirty = true;
		
		__buffer = new HBBuffer ();
		__buffer.direction = HBDirection.LTR;
		__buffer.script = HBScript.INVALID;
		__buffer.language = new HBLanguage ("en");
		
		//#if (lime_cffi && !macro)
		//__handle = NativeCFFI.lime_text_layout_create (__direction, __script, __language);
		//#end
		
	}
	
	
	@:noCompletion private function __position ():Void {
		
		positions = [];
		
		#if (lime_cffi && !macro)
		
		if (__buffer != null && text != null && text != "" && font != null && font.src != null) {
			
			var hbFont;
			
			if (font.__hbFont == null) {
				
				@:privateAccess font.__setSize (size);
				font.__hbFont = new HBFTFont (font);
				
			}
			
			hbFont = font.__hbFont;
			//hbFont.size = size;
			
			__buffer.length = 0;
			__buffer.addUTF8 (text, 0, text.length);
			
			HB.shape (hbFont, __buffer);
			
			var glyphInfo = __buffer.getGlyphInfo ();
			var glyphPositions = __buffer.getGlyphPositions ();
			
			var info, position;
			
			for (i in 0...glyphInfo.length) {
				
				info = glyphInfo[i];
				position = glyphPositions[i];
				
				positions.push (new GlyphPosition (info.codepoint, new Vector2 (position.xAdvance / 64, position.yAdvance / 64), new Vector2 (position.xOffset / 64, position.yOffset / 64)));
				
			}
			
		}
		
		#end
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	@:noCompletion private function get_positions ():Array<GlyphPosition> {
		
		if (__dirty) {
			
			__dirty = false;
			__position ();
			
		}
		
		return positions;
		
	}
	
	
	@:noCompletion private function get_direction ():TextDirection {
		
		return __direction;
		
	}
	
	
	@:noCompletion private function set_direction (value:TextDirection):TextDirection {
		
		if (value == __direction) return value;
		
		__direction = value;
		
		//#if (lime_cffi && !macro)
		//NativeCFFI.lime_text_layout_set_direction (__handle, value);
		//#end
		
		__dirty = true;
		
		return value;
		
	}
	
	
	@:noCompletion private function set_font (value:Font):Font {
		
		if (value == this.font) return value;
		
		this.font = value;
		__dirty = true;
		return value;
		
	}
	
	
	@:noCompletion private function get_glyphs ():Array<Glyph> {
		
		var glyphs = [];
		
		for (position in positions) {
			
			glyphs.push (position.glyph);
			
		}
		
		return glyphs;
		
	}
	
	
	@:noCompletion private function get_language ():String {
		
		return __language;
		
	}
	
	
	@:noCompletion private function set_language (value:String):String {
		
		if (value == __language) return value;
		
		__language = value;
		
		//#if (lime_cffi && !macro)
		//NativeCFFI.lime_text_layout_set_language (__handle, value);
		//#end
		
		__dirty = true;
		
		return value;
		
	}
	
	
	@:noCompletion private function get_script ():TextScript {
		
		return __script;
		
	}
	
	
	@:noCompletion private function set_script (value:TextScript):TextScript {
		
		if (value == __script) return value;
		
		__script = value;
		
		//#if (lime_cffi && !macro)
		//NativeCFFI.lime_text_layout_set_script (__handle, value);
		//#end
		
		__dirty = true;
		
		return value;
		
	}
	
	
	@:noCompletion private function set_size (value:Int):Int {
		
		if (value == this.size) return value;
		
		this.size = value;
		__dirty = true;
		return value;
		
	}
	
	
	@:noCompletion private function set_text (value:String):String {
		
		if (value == this.text) return value;
		
		this.text = value;
		__dirty = true;
		return value;
		
	}
	
	
}