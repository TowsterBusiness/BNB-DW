package;

import towsterFlxUtil.TowPaths;
import flixel.system.FlxSound;
import flixel.util.FlxSave;
import flixel.FlxG;
import flixel.FlxSubState;

class OptionsBirdIncSubstate extends FlxSubState
{
    //! IM TO LAZY TO CHANG THE VARIABLE NAMES
	var birdSpdNum:String;
	var birdSpdText:Alphabet;

	var arrowRight:Alphabet;
	var arrowLeft:Alphabet;

	var scrollSound:FlxSound;

	override function create()
	{
		super.create();

		if (FlxG.save.data.globalIncLoc == null)
		{
			birdSpdNum = "LEFT";
		}
		else
		{
			birdSpdNum = FlxG.save.data.globalIncLoc;
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

		if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.LEFT)
		{
			if (birdSpdNum == "RIGHT")
                birdSpdNum = "LEFT";
            else if (birdSpdNum == "LEFT")
                birdSpdNum = "RIGHT";
			scrollSound.play(true);
			updateText();
		}

		if (FlxG.keys.anyJustPressed([ESCAPE, ENTER]))
		{
			FlxG.save.data.globalIncLoc = birdSpdNum;
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
