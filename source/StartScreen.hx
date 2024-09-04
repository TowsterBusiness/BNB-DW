package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import haxe.Timer;
import towsterFlxUtil.Fade;
import towsterFlxUtil.TowPaths;
import towsterFlxUtil.TowSprite;
import towsterFlxUtil.TowUtils;

class StartScreen extends FlxState
{
	var conductor:Conductor;
	var song:FlxSound;
	var enterSound:FlxSound;

	var blackBG:FlxSprite;
	var BG:FlxSprite;
	var bench:FlxSprite;
	var bushes:FlxSprite;
	var logoBumpin:TowSprite;
	var mainChar:FlxSprite;
	var enterButton:TowSprite;

	var blackScreen:FlxSprite;
	var whiteScreen:FlxSprite;
	var textSpr:FlxText;
	var fade:Fade;

	var playingIntro:Bool = true;

	override function create()
	{
		super.create();

		FlxG.sound.playMusic(TowPaths.getFilePath('sounds/menu/neg_bnb_menu_music_maybe_.wav'), 1, true);
		enterSound = FlxG.sound.load(TowPaths.getFilePath('sounds/menu/confirmMenu.ogg'));

		BG = new FlxSprite(0, 0).loadGraphic(TowPaths.getFilePath('start screen/sky', PNG));
		BG.scale.set(0.7, 0.7);
		BG.updateHitbox();
		add(BG);

		bushes = new FlxSprite(-245, 230).loadGraphic(TowPaths.getFilePath('start screen/bushes', PNG));
		bushes.scale.set(0.7, 0.7);
		bushes.updateHitbox();
		bushes.antialiasing = true;
		add(bushes);

		logoBumpin = new TowSprite(75, 65, 'start screen/logoBumpin', true);
		logoBumpin.scale.set(0.7, 0.7);
		logoBumpin.updateHitbox();
		logoBumpin.playAnim('idle');
		logoBumpin.antialiasing = true;
		add(logoBumpin);

		mainChar = new FlxSprite(765, 160);
		mainChar.frames = TowPaths.getAnimation('start screen/bob_bosip_dance_title');
		mainChar.animation.addByIndices("right", "bob and bosip bop0", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], '', 24, false);
		mainChar.animation.addByIndices("left", "bob and bosip bop0", [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27], '', 24, false);
		mainChar.scale.set(0.6, 0.6);
		mainChar.updateHitbox();
		mainChar.antialiasing = true;
		add(mainChar);

		enterButton = new TowSprite(12, 511, 'start screen/pressEnter', true);
		enterButton.scale.set(0.7, 0.7);
		enterButton.playAnim('idle');
		add(enterButton);

		blackScreen = new FlxSprite(0, 0).loadGraphic(TowPaths.getFilePath('blackScreen', PNG));
		add(blackScreen);

		whiteScreen = new FlxSprite(0, 0).loadGraphic(TowPaths.getFilePath('whiteScreen', PNG));
		whiteScreen.alpha = 0;
		add(whiteScreen);

		textSpr = new FlxText(0, 0, 0, "", 80);
		textSpr.font = TowPaths.getFilePath('fonts/setofont.ttf');
		textSpr.alignment = CENTER;
		textSpr.screenCenter(XY);
		add(textSpr);

		fade = new Fade(true);
		add(fade);
	}

	var first = 0;

	var last:Float = 0;

	var right:Bool = true;
	var startText:Array<String> = [
		"Bob & Bosip Date Week",
		"Made with love and care by:",
		"Stole assets from FNF",
		"Inspired by Rythm Heaven",
	];
	var textBeatNum:Int;

	override function update(elapsed:Float)
	{
		if (first == 0)
		{
			conductor = new Conductor([{"bpm": 125, "time": 0}]);
			first = -1;
		}

		BG.y = -50 * (Math.sin(2 * Timer.stamp() * 3.1415) / 2 + 0.5);

		if (conductor.pastBeat())
		{
			if (right)
			{
				mainChar.animation.play('right');
				logoBumpin.playAnim('idle');
			}
			else
			{
				mainChar.animation.play('left');
				if (playingIntro)
				{
					if (textBeatNum < startText.length)
					{
						textSpr.text = startText[textBeatNum];
						textSpr.screenCenter(XY);
					}
					else if (textBeatNum == startText.length)
					{
						whiteScreen.alpha = 1;
						blackScreen.alpha = 0;
						textSpr.alpha = 0;
						FlxTween.tween(whiteScreen, {alpha: 0}, 2);
						playingIntro = false;
					}
					textBeatNum++;
				}
			}
			right = !right;
		}

		if (FlxG.keys.justPressed.ENTER && enterButton.animation.curAnim.name != 'pressed' && playingIntro == false)
		{
			enterButton.playAnim('pressed');
			enterSound.play();
			fade.goIn(new MenuState());
		}
		else if (FlxG.keys.justPressed.ENTER && playingIntro == true)
		{
			whiteScreen.alpha = 1;
			blackScreen.alpha = 0;
			textSpr.alpha = 0;
			FlxTween.tween(whiteScreen, {alpha: 0}, 2);
			playingIntro = false;
		}
		if (FlxG.keys.justPressed.U)
		{
			FlxG.switchState(new StartScreen());
		}
		super.update(elapsed);
	}

	override function onFocusLost()
	{
		conductor.pause();
		super.onFocusLost();
	}

	override function onFocus()
	{
		conductor.unPause();
		super.onFocus();
	}
}
