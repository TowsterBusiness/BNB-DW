package;

import towsterFlxUtil.Fade;
import flixel.system.FlxSound;
import flixel.text.FlxBitmapText;
import flixel.FlxBasic;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import towsterFlxUtil.TowUtils;
import flixel.FlxG;
import towsterFlxUtil.TowSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import towsterFlxUtil.TowPaths;
import flixel.FlxSprite;
import flixel.FlxState;

class MenuState extends FlxState
{
	var BG:FlxSprite;
	var buttons:FlxTypedSpriteGroup<TowSprite>;

	var confirmSound:FlxSound;
	var scrollSound:FlxSound;
	var cancelSound:FlxSound;

	var fade:Fade;

	// TODO make more if you have time
	var buttonList:Array<String> = ['menu_story_mode', 'menu_credits', 'menu_options'];
	var buttonOffsetMult:Int = 150;
	var buttonOffsetAdd:Int = 50;
	var selectedButtonIndex:Int = 0;

	override function create()
	{
		super.create();

		confirmSound = FlxG.sound.load(TowPaths.getFilePath('menu/confirmMenu', OGG));
		cancelSound = FlxG.sound.load(TowPaths.getFilePath('menu/cancelMenu', OGG));
		scrollSound = FlxG.sound.load(TowPaths.getFilePath('menu/scrollMenu', OGG));

		BG = new FlxSprite(0, 0).loadGraphic(TowPaths.getFilePath('menus/menuBG', PNG));
		add(BG);

		buttons = new FlxTypedSpriteGroup(0, 0, buttonList.length);
		add(buttons);

		for (index => buttonName in buttonList)
		{
			var tempButton:TowSprite = new TowSprite(0, index * buttonOffsetMult + buttonOffsetAdd, 'menus/' + buttonName);
			tempButton.animation.addByPrefix('basic', 'basic', 24);
			tempButton.animation.addByPrefix('white', 'white', 24);
			tempButton.playAnim('basic');
			tempButton.screenCenter(X);
			buttons.add(tempButton);
		}
		buttons.members[0].playAnim('white');
		buttons.members[0].screenCenter(X);

		fade = new Fade(false);
		add(fade);
		fade.goOut();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.DOWN)
		{
			selectedButtonIndex++;
			selectedButtonIndex %= buttonList.length;
			scrollSound.play(true);
			updateButtons();
		}

		if (FlxG.keys.justPressed.UP)
		{
			selectedButtonIndex--;
			if (selectedButtonIndex < 0)
				selectedButtonIndex = buttonList.length - 1;
			scrollSound.play(true);
			updateButtons();
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			switch (selectedButtonIndex)
			{
				case 0:
					StaticVar.nextSong = 'LoveBirds';
					FlxTween.tween(FlxG.sound.music, {volume: 0}, 2);
					confirmSound.play(true);
					fade.goIn(new DialogueState());
				case 1:
					cancelSound.play(true);
				case 2:
					fade.goIn(new OptionsState());
					confirmSound.play(true);
			}
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			fade.goIn(new StartScreen());
		}

		super.update(elapsed);
	}

	function updateButtons()
	{
		buttons.forEachAlive(function(btn)
		{
			btn.playAnim('basic');
			btn.screenCenter(X);
		});
		buttons.members[selectedButtonIndex].playAnim('white');
		buttons.members[selectedButtonIndex].screenCenter(X);
	}
}
