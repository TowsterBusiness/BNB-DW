package;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import openfl.Lib;
import towsterFlxUtil.TowPaths;

class RatingSprite extends FlxSprite
{
	public function new(rating:Int)
	{
		super(0, 0);
		var fileName:String = "sick";
		switch (rating)
		{
			case 0:
				fileName = 'sick';
			case 1:
				fileName = 'good';
			case 2:
				fileName = 'bad';
			case 3:
				fileName = 'shit';
		}
		loadGraphic(TowPaths.getFilePath('scoring/' + fileName, PNG));
		scale.set(0.5, 0.5);
		updateHitbox();

		velocity = new FlxPoint(0, -100);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		velocity.y += elapsed * 500;

		alpha -= elapsed * 1;

		if (y > Lib.application.window.height)
		{
			kill();
		}
	}
}
