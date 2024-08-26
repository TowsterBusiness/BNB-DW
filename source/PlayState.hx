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
import towsterFlxUtil.*;

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
		// everything after this point will not be covered with black in gameover
		bob = new TowSprite(675, 190, 'characters/bob_assets');
		bob.loadAnimations('characters/bob');
		bob.scale.set(0.5, 0.5);
		bob.playAnim('idle');
		bob.updateHitbox();
		bosip = new TowSprite(500, 150, 'characters/bosip_assets');
		bosip.loadAnimations('characters/bosip');
		bosip.scale.set(0.5, 0.5);
		bosip.playAnim('idle');
		bosip.updateHitbox();
		bosip.health = 50;
		add(bob);
		add(bosip);

		birdList = new FlxTypedSpriteGroup(0, 0, 999);
		add(birdList);

		countSprite = new SongCountDownSprite();
		add(countSprite);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (countState == 0)
		{
			countConductor = new Conductor(songJson.bpmList, -1000);
			countState = 1;
		}
	}

	function organizeNotes()
	{
		var noteList = songJson.chart;

		var usedTimeList = [];

		birdList.forEachAlive(function(bird)
		{
			usedTimeList.push(bird.time);
		});

		for (note in noteList)
		{
			if (!usedTimeList.contains(note.time) && conductor.getMil() < note.time)
			{
				birdList.add(new Bird(note.id, note.time, conductor.getBPM().bpm));
			}
		}
	}

	function getRank(time:Int)
	{
		var difference = Math.abs(conductor.getMil() - time);

		for (index => rank in rankings)
		{
			if (difference < rank)
				return index;
		}
		return rankings.length;
	}

	function gameover()
	{
		isGameover = true;
		bob.playAnim('gameover');
		bosip.playAnim('gameover');
		conductor.pause();

		FlxTween.tween(songInst, {volume: 0}, 2);
		FlxTween.tween(gameoverBlack, {alpha: 0.9}, 2);
	}

	function retry()
	{
		bob.playAnim('retry');
		bosip.playAnim('idle');
		FlxTween.tween(gameoverBlack, {alpha: 0}, 2, {
			onComplete: (tween) ->
			{
				FlxG.switchState(new PlayState());
			}
		});
	}

	function changeHealth(health:Int)
	{
		bosip.health += health;
		if (bosip.health < 0)
		{
			bosip.health = 0;
		}
		else if (bosip.health > 100)
		{
			bosip.health = 100;
		}

		healthBar.percent = bosip.health;

		FlxTween.tween(healthP1, {x: healthBar.percent / 100 * 590 + 255}, 0.5, {ease: FlxEase.expoOut});
		FlxTween.tween(healthP2, {x: healthBar.percent / 100 * 590 + 305}, 0.5, {ease: FlxEase.expoOut});

		if (healthBar.percent <= 0)
		{
			gameover();
		}
	}

	override function onFocusLost()
	{
		if (conductor != null)
			conductor.pause();
		else
			countConductor.pause();
		super.onFocusLost();
	}

	override function onFocus()
	{
		if (!isGameover)
		{
			if (conductor != null)
			{
				conductor.unPause();
				songInst.time = conductor.getMil();
			}
			else
				countConductor.unPause();
		}

		super.onFocus();
	}
}
