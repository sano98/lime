package lime.media.openal;


import lime.system.CFFIPointer;

@:allow(lime.media.openal.AL)


abstract ALEffect(CFFIPointer) from CFFIPointer to CFFIPointer {
	
	
	private inline function new (handle:CFFIPointer) {
		
		this = handle;
		
	}
	
	
}