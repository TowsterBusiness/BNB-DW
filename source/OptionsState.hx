package;

import flixel.system.FlxSound;
import flixel.FlxBasic;
import flixel.FlxG;
import towsterFlxUtil.TowPaths;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxState;

class OptionsState extends FlxState
{
	var BG:FlxSprite;

	var optionsText:FlxTypedSpriteGroup<Alphabet>;
	var optionsPointer:Int = 0;
	var options:Array<String> = ['Offset', 'Bird Speed', "Bird Start Location"];

	var selectorRight:Alphabet;
	var selectorLeft:Alphabet;

	var scrollSound:FlxSound;

	var fadeColor = 0xB9000000;

	override function create()
	{
		super.create();

		BG = new FlxSprite(0, 0).loadGraphic(TowPaths.getFilePath('menus/menuBGMagenta', PNG));
		add(BG);

		optionsText = new FlxTypedSpriteGroup(0, 100, options.length);
		var optionTextOffset = 0;
		for (optionName in options)
		{
			var tempAlphabet:Alphabet = new Alphabet(0, optionTextOffset, optionName, true);
			optionTextOffset += 90;
			tempAlphabet.screenCenter(X);
			optionsText.add(tempAlphabet);
		}
		add(optionsText);

		selectorRight = new Alphabet(0, 0, '<', true);
		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorRight);
		add(selectorLeft);

		updateSelector();

		scrollSound = TowPaths.getFile('menu/scrollMenu', OGG);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.DOWN)
		{
			optionsPointer++;
			optionsPointer %= options.length;
			updateSelector();
			scrollSound.play(true);
		}

		if (FlxG.keys.justPressed.UP)
		{
			optionsPointer--;
			if (optionsPointer < 0)
			{
				optionsPointer = options.length - 1;
			}
			updateSelector();
			scrollSound.play(true);
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			switch (optionsPointer)
			{
				case 0:
					openSubState(new OptionsOffsetSubstate(fadeColor));
				case 1:
					openSubState(new OptionsBirdSpeedSubstate(fadeColor));
				case 2:
					openSubState(new OptionsBirdIncSubstate(fadeColor));
			}
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}

	function updateSelector()
	{
		var selectedText:Alphabet = optionsText.members[optionsPointer];

		selectorLeft.x = selectedText.x - 63;
		selectorLeft.y = selectedText.y;
		selectorRight.x = selectedText.x + selectedText.width + 10;
		selectorRight.y = selectedText.y;
	}
}
