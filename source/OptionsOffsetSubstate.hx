package;

import towsterFlxUtil.TowPaths;
import flixel.system.FlxSound;
import flixel.util.FlxSave;
import flixel.FlxG;
import flixel.FlxSubState;

class OptionsOffsetSubstate extends FlxSubState
{
	var offsetNum:Int = 0;
	var offsetText:Alphabet;

	var arrowRight:Alphabet;
	var arrowLeft:Alphabet;

	var scrollSound:FlxSound;

	override function create()
	{
		super.create();

		if (FlxG.save.data.globalOffset == null)
		{
			offsetNum = 0;
		}
		else
		{
			offsetNum = FlxG.save.data.globalOffset;
		}

		offsetText = new Alphabet(0, 0, '' + offsetNum, true);
		add(offsetText);
		arrowRight = new Alphabet(0, 0, '>', true);
		arrowRight.screenCenter(Y);
		add(arrowRight);
		arrowLeft = new Alphabet(0, 0, '<', true);
		arrowLeft.screenCenter(Y);
		add(arrowLeft);
		updateText();

		scrollSound = TowPaths.getFile('menu/scrollMenu', OGG);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.RIGHT)
		{
			offsetNum += 1;
			scrollSound.play(true);
			updateText();
		}

		if (FlxG.keys.justPressed.LEFT)
		{
			offsetNum -= 1;
			scrollSound.play(true);
			updateText();
		}

		if (FlxG.keys.anyJustPressed([ESCAPE, ENTER]))
		{
			FlxG.save.data.globalOffset = offsetNum;
			FlxG.save.flush();
			close();
		}
	}

	function updateText()
	{
		offsetText.changeText('' + offsetNum);
		offsetText.screenCenter(XY);
		arrowLeft.x = offsetText.x - arrowLeft.width - 30;
		arrowRight.x = offsetText.x + offsetText.width + 30;
	}
}
