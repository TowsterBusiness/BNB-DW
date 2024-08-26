package;

import towsterFlxUtil.TowPaths;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;

class SongCountDownSprite extends FlxSprite
{
	public var state:Int = 2;

	public function new()
	{
		super(0, 0);
		alpha = 0;
		loadGraphic(TowPaths.getFilePath('123/1', PNG));
		screenCenter(XY);
	}

	public function next()
	{
		alpha = 1;
		FlxTween.tween(this, {alpha: 0}, 0.5, {
			onComplete: (x) ->
			{
				if (state < 5) {
					loadGraphic(TowPaths.getFilePath('123/' + state, PNG));
					screenCenter(XY);
					state++;
				}
			}
		});
	}
}
