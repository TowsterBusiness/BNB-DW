package;

import towsterFlxUtil.TowPaths;
import flixel.system.FlxSound;
import haxe.Timer;
import flixel.text.FlxText;

class DialogueText extends FlxText
{
	var finText:String = '';

	var dialogueSound:FlxSound;

	public function new()
	{
		super(358, 506, 0, '', 20);

		dialogueSound = TowPaths.getFile('dialogue', OGG);

		var timer:Timer = new Timer(20);
		timer.run = function()
		{
			if (text < finText)
			{
				text += finText.charAt(text.length);
				dialogueSound.play(true);
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function nextText(text:String)
	{
		super.text = '';
		finText = text;
	}

	public function finish():Void
	{
		super.text = finText;
	}

	public function isFinished():Bool
	{
		return text >= finText;
	}
}
