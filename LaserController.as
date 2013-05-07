class LaserController extends MovieClip {
	
	var nSpeed:Number;
	var player:Boolean;
	var sndFire:Sound;
	
	function LaserController() {
		nSpeed = 30;
		player = true;
		sndFire = new Sound(_root);
		sndFire.attachSound("laser.wav");
		if(!_root.wm.muted) {
			sndFire.start();
		}
	}
	
	function setLaser(shooter:Boolean) {
		player = shooter;
		if(!player) {
			nSpeed = 15;
		}
	}
	
	function kill() {
		this.removeMovieClip();
	}
	
	function onEnterFrame() {
		if(player) {
			_y -= nSpeed;
		} else {
			_y += nSpeed;
		}
	}
	
}