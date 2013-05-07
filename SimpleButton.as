class SimpleButton extends MovieClip {
	
	var objTarget:Object;
	var functionReference:Function;
	var frameIndex:Number;
	
	function SimpleButton() {
		//trace("Hello. My name is " + _name);
		stop();
		//this["label"].text = "test";
	}
	
	//setter
	function setTarget(target:Object, funcRef:Function) {
		objTarget = target;
		functionReference = funcRef;
	}
	
	function setTargetFrame(frame:Number) {
		frameIndex = frame;
	}
	
	function onPress() {
		gotoAndStop("down");
	}
	
	function onRelease() {
		gotoAndStop("over");
		//send message to target (call function on target)
		if(frameIndex != undefined) {
			_root.gotoAndStop(frameIndex);
		} else {
			functionReference.call(objTarget);
		}
	}
	
	function onReleaseOutside() {
		gotoAndStop("up");
	}
	
	function onRollOver() {
		gotoAndStop("over");
	}
	
	function onRollOut() {
		gotoAndStop("up");
	}
	
}