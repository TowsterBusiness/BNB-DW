package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import towsterFlxUtil.TowSprite;

class Bird extends TowSprite
{
	public var time = 0;

	// pre, peck, rate, post
	public var beats:Array<Int> = [0, 0, 0];

	var hasFlownIn:Bool = false;
	var hasFlownOut:Bool = false;
	var hasPecked:Bool = false;

	public var shouldRank:Bool = true;

	var bpm:Float = 120;
	var isBop:Bool = false;

	var peckSound:FlxSound;
	var flyInSound:FlxSound;
	var throwSound:FlxSound;
	var squawkSound:FlxSound;

	var incLoc:String = "LEFT";

	public function new(id:String, time:Int, bpm:Float)
	{
		this.bpm = bpm;
		this.time = time;

		peckSound = FlxG.sound.load('assets/sounds/cromch.wav');
		flyInSound = FlxG.sound.load('assets/sounds/swoop.wav');

		if (FlxG.save.data.globalIncLoc == null)
		{
			incLoc = "LEFT";
		}
		else
		{
			incLoc = FlxG.save.data.globalIncLoc;
		}

		var fileName = '';
		var jsonFileName = '';
		switch (id)
		{
			case 'bird 1':
				fileName = 'bird_assets';
				jsonFileName = 'bird';
				beats = [-4, 4, 8, 12];
			case 'bird 2':
				fileName = 'twitter_bird_assets';
				jsonFileName = 'twitter-bird';
				beats = [-2, 2, 4, 6];
			case 'bird 3':
				fileName = 'bird_assets';
				jsonFileName = 'bird';
				beats = [-4, 2, 4, 6];
		}
	}
