package;

import flixel.*;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import haxe.Timer;

class PlayState extends FlxState
{
	var cameraHUD:FlxCamera;

	var isGameover:Bool = false;

	var firstUpdate:Bool = true;
	var countState:Int = 0;

	var inputKeys:Array<FlxKey> = ['SPACE'];

	var songInst:FlxSound;

	var throwSound:FlxSound;

	var bob:TowSprite;
	var bosip:TowSprite;
	var BG:Background;

	var gameoverBlack:FlxSprite;

	var birdList:FlxTypedSpriteGroup<Bird>;

	var songJson:SongJson;
	var songPath = 'LoveBirds';

	var offset:Int = 0;
	// Sick, Good, Ok, Bad, Shit
	var ratingSprite:FlxTypedSpriteGroup<RatingSprite>;
	//* I coppied this into SongFinishedSubState so be careful
	var rankings = [15, 25, 40, 100];
	var rankList:Array<Rank> = [];
	var rankNames = ["sick", "good", "Bad", "Shit"];

	var healthBar:FlxBar;
	var healthBG:FlxSprite;
	var healthP1:HealthIcon;
	var healthP2:HealthIcon;

	/*
		TODO: Add end-screen
		TODO: Credits
		TODO: Freeplay
		TODO: Clean up

	 */
	override public function create()
	{
		super.create();

		songPath = StaticVar.nextSong;
		songJson = TowPaths.getFile('songs/' + songPath + '/chart', JSON, false);

		songInst = FlxG.sound.load(TowPaths.getFilePath('songs/' + songPath + '/Inst', OGG, false));
		songInst.onComplete = () ->
		{
			if (!isGameover)
				win();
		};
		throwSound = FlxG.sound.load('assets/sounds/toss.wav');

		offset = 1000;

		BG = new Background('day');
		add(BG);

		ratingSprite = new FlxTypedSpriteGroup(100, 100, 99);
		add(ratingSprite);

		healthBG = new FlxSprite(0, 46).loadGraphic(TowPaths.getFilePath('healthBar', PNG));
		healthBG.screenCenter(X);
		add(healthBG);

		healthBar = new FlxBar(0, 50, LEFT_TO_RIGHT, 590, 11);
		healthBar.createFilledBar(0xFF859ac1, 0xFFfdd173);
		healthBar.screenCenter(X);
		healthBar.percent = 50;
		add(healthBar);

		healthP1 = new HealthIcon(550, 5, 'bosip', true);
		healthP2 = new HealthIcon(600, 5, 'bob-sleep', false);
		add(healthP2);
		add(healthP1);

		// please tell me if there is a better way of doing this...
		gameoverBlack = new FlxSprite(0, 0).loadGraphic(TowPaths.getFilePath('blackScreen_holed', PNG));
		gameoverBlack.alpha = 0;
		add(gameoverBlack);
	}
}
