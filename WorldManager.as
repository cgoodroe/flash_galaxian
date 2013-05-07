class WorldManager {
    
	var player:MovieClip;
	var sndCoin:Sound;
	var sndStart:Sound;
	var count:Number;
	var aliens:Array;
	var numAliens:Number;
	var nSpeed:Number;
	var sndIntro:Sound;
	var playerLaser:Array;
	var numAlien:Number;
    var moveCount:Number;
	var score:Number;
	var level:Number;
	var kills:Number;
	var over:Boolean;
	var isPlaying:Boolean;
	var difficulty:Number;
	var fireRate:Number;
	var lv:LoadVars;
	var arrDifficulty:Array;
	var alienLaser:Array;
	var muted:Boolean;
	var sndMusic:Sound;
	
	function WorldManager() {
        _root.wm = this;
		_root.start_mc.setTargetFrame(4);
		_root.credits_mc.setTargetFrame(6);
		_root.rules_mc.setTargetFrame(5);
		count = 0;
		aliens = new Array();
		numAliens = 15;
		nSpeed = 30;
		playerLaser = new Array();
		numAlien = 1;
		moveCount = 0;
		score = 0;
		level = 1;
		kills = 0;
		isPlaying = false;
		muted = false;
		
		difficulty = 0;//loaded
		fireRate = 2;//loaded
		alienLaser = new Array();
		
		lv = new LoadVars();
		lv.wm = this;
		lv.load("difficulty.txt");
		lv.onLoad = function(success:Boolean) {
			if(success){
				this.wm.arrDifficulty = this.myDifficulty.split(",");
			} else {
				trace("Data load error.");
			}
		}
		
		sndCoin = new Sound(_root);
		sndCoin.attachSound("insertcoin.mp3");
		if(!muted) {
			sndCoin.start();
		}
		sndMusic = new Sound(_root);
		sndMusic.attachSound("summerparty.mp3");
    } // End of the function
	
	function gameStart() {
		player = _root.attachMovie("Player_Clip", "player_mc", _root.getNextHighestDepth());
		player._x = 135;
		player._y = 360;
		spawnAliens(level);
		isPlaying = true;
		
		sndIntro = new Sound(_root);
		sndIntro.attachSound("gamestart.mp3");
		if(!muted) {
			sndIntro.start();
			sndMusic.start(0, 100);
		}
	}
	
	function mute(gameFrame:Boolean) {
		if(muted && gameFrame) {
			muted = false;
			sndMusic.start(0, 100);
		} else if(muted) {
			muted = false;
		} else {
			muted = true;
			stopAllSounds();
		}
	}
	
	function spawnAliens(numLevel:Number) {
		nSpeed = Math.abs(nSpeed);
		if(arrDifficulty[0] != undefined) {
			if(numLevel <= arrDifficulty.length) {
				difficulty = parseInt(arrDifficulty[numLevel-1]);
			} else {
				difficulty = parseInt(arrDifficulty[arrDifficulty.length-1]);
			}
		}
		var xPos = 50;
		var yPos = 0;
		if(numAlien == 8) {
			numAlien = 1;
		}
		for(var i=0; i<numAliens; i++) {
			var alien:MovieClip = _root.attachMovie("Alien" + numAlien + "_Clip", "alien_mc" + i, _root.getNextHighestDepth());
			if(i%5 == 0) {
				yPos += 50;
				xPos = 50;
			}
			alien._x = 100 + xPos;
			xPos += 60;
			alien._y = 25 + yPos;
			aliens.push(alien);
		}
		numAlien++;
		if(arrDifficulty[0] == undefined && difficulty < 6) {
			difficulty += 2;
		}
	}
	
	function killGame() {
		player.removeMovieClip();
		for(var i=0; i<aliens.length; i++) {
			aliens[i].removeMovieClip();
		}
		for(var i=0; i<playerLaser.length; i++) {
			playerLaser[i].removeMovieClip();
		}
		for(var i=0; i<alienLaser.length; i++) {
			alienLaser[i].removeMovieClip();
		}
	}
	
	function lose() {
		_root.over_mc.swapDepths(_root.getNextHighestDepth());
		_root.over_mc._visible = true;
		player.kill();
		isPlaying = false;
		over = true;
	}
	
    function renderFrame() {
		count++;
		if (count > (12 - difficulty) && isPlaying && !over) {
			count = 0;
			for(var i=0; i<aliens.length && moveCount == 0 && !over; i++) {
				if (aliens[i]._x < 130 || aliens[i]._x > 570) {
					nSpeed = -nSpeed;
					for(var j=0; j<aliens.length; j++) {
						aliens[j]._y += 50;
					}
					moveCount = 1;
				}
			}
			for(var i=0; i<aliens.length && !over; i++) {
				if(moveCount != 1) {
					aliens[i]._x += nSpeed;
				}
				fireRate = Math.floor(Math.random()*150);
				if(difficulty > fireRate) {
					aliens[i].fire();
				}
			}
			if(moveCount == 2) {
				moveCount = 0;
			}
			if(moveCount == 1) {
				moveCount = 2;
			}
		}
		for(var i=0; i<aliens.length && !over; i++) {
			for(var j=0; j<playerLaser.length && !over; j++) {
				if(playerLaser[j].hitTest(aliens[i])) {
					aliens[i].kill();
					aliens.splice(i, 1);
					kills++;
					_root.kills_mc.text = kills;
					score += (difficulty+1);
					_root.score_mc.text = score;
					playerLaser[j].kill();
					playerLaser.splice(j, 1);
				}
				if(playerLaser[j]._y < 56 || playerLaser[j]._y > 390) {
					playerLaser[j].kill();
					playerLaser.splice(j, 1);
				}
			}
			if(aliens.length == 0 && !over) {
				level++;
				_root.level_mc.text = level;
				spawnAliens(level);
			}
			if(aliens[i]._y >= 300 && aliens[i]._y != undefined) {
				lose();
			}
		}
		for(var i=0; i<alienLaser.length; i++) {
			if(alienLaser[i].hitTest(player)) {
				lose();
			}
			if(alienLaser[i]._y < 56 || alienLaser[i]._y > 390) {
				alienLaser[i].kill();
				alienLaser.splice(i, 1);
			}
		}
    } // End of the function
	
} // End of Class
