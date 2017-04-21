package lime.text.harfbuzz;


@:enum abstract HBDirection(Int) from Int to Int {
	
	public var HB_DIRECTION_INVALID = 0;
	public var HB_DIRECTION_LTR = 4;
	public var HB_DIRECTION_RTL = 5;
	public var HB_DIRECTION_TTB = 6;
	public var HB_DIRECTION_BTT = 7;
	
}