class PlayerController extends MovieClip {
	
	var sndOver:Sound;
	var explosion:MovieClip;
	
	function PlayerController() {
		var listen = new Object();
		listen.wm = this;
		listen.onKeyUp = function() {
			if (Key.getCode() == Key.LEFT) {
				if(listen.wm._x > 135) {
					listen.wm._x -= 30;
				}
			}
			if (Key.getCode() == Key.RIGHT) {
				if(listen.wm._x < 610) {
					listen.wm._x += 30;
				}
			}
			if (Key.getCode() == Key.SPACE) {
				if(_root.wm.playerLaser.length < 2) {
					listen.wm.fire();
				}
			}
			// end if
		};
		Key.addListener(listen);
	}
	// End of the function
	
	function fire() {
		var laser:MovieClip = _root.attachMovie("Laser_Clip", "playerlaser_mc" + _root.wm.playerLaser.length, _root.getNextHighestDepth());
		laser.setLaser(true);
		laser._x = _x;
		laser._y = _y;
		_root.wm.playerLaser.push(laser);
	}
	
	function kill() {
		sndOver = new Sound(_root);
		sndOver.attachSound("playerexplode.mp3");
		if(!_root.wm.muted) {
			sndOver.start();
		}
		explosion = _root.attachMovie("Explosion_Clip", "explosion_mc", _root.getNextHighestDepth());
		explosion._x = _x - ((explosion._width)/2);
		explosion._y = _y - ((explosion._height)/2);
		this.removeMovieClip();
	}
	
}
// End of Class
