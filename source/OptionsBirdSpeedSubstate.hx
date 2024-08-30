package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.system.FlxSound;
import flixel.util.FlxSave;
import towsterFlxUtil.TowPaths;

class OptionsBirdSpeedSubstate extends FlxSubState
{
	var birdSpdNum:Float = 0;
	var birdSpdText:Alphabet;

	var arrowRight:Alphabet;
	var arrowLeft:Alphabet;

	var scrollSound:FlxSound;

	override function create()
	{
		super.create();

		if (FlxG.save.data.globalbirdSpd == null)
		{
			birdSpdNum = 1;
		}
		else
		{
			birdSpdNum = FlxG.save.data.globalbirdSpd;
		}

		birdSpdText = new Alphabet(0, 0, birdSpdNum + '', true);
		add(birdSpdText);
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
			birdSpdNum *= 10;
			birdSpdNum += 1;
			birdSpdNum = Math.floor(birdSpdNum);
			birdSpdNum /= 10;
			scrollSound.play(true);
			updateText();
		}

		if (FlxG.keys.justPressed.LEFT)
		{
			birdSpdNum -= 0.1;
			birdSpdNum *= 10;
			birdSpdNum = Math.floor(birdSpdNum);
			birdSpdNum /= 10;
			if (birdSpdNum <= 0.1)
			{
				birdSpdNum = 0.1;
			}
			scrollSound.play(true);
			updateText();
		}

		if (FlxG.keys.anyJustPressed([ESCAPE, ENTER]))
		{
			FlxG.save.data.globalbirdSpd = birdSpdNum;
			FlxG.save.flush();
			close();
		}
	}

	function updateText()
	{
		trace(birdSpdNum);
		birdSpdText.changeText('' + birdSpdNum);
		birdSpdText.screenCenter(XY);
		arrowLeft.x = birdSpdText.x - arrowLeft.width - 30;
		arrowRight.x = birdSpdText.x + birdSpdText.width + 30;
	}
}
