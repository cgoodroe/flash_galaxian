class AlienController extends MovieClip {
	
	var explosion:MovieClip;
	var sndExplode:Sound;
	
	function AlienController() {
		sndExplode = new Sound(_root);
		sndExplode.attachSound("alienexplode.mp3");
	}

	function fire() {
		var laser:MovieClip = _root.attachMovie("Laser_Clip", "alienlaser_mc" + _root.wm.alienLaser.length, _root.getNextHighestDepth());
		laser.setLaser(false);
		laser._x = _x;
		laser._y = _y;
		_root.wm.alienLaser.push(laser);
	}
	
	function kill() {
		explosion = _root.attachMovie("Explosion_Clip", "explosion_mc", _root.getNextHighestDepth());
		explosion._x = _x - ((explosion._width)/4);
		explosion._y = _y - ((explosion._height)/4);
		if(!_root.wm.muted) {
			sndExplode.start();
		}
		this.removeMovieClip();
	}
	
}
// End of Class
