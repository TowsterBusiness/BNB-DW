package towsterFlxUtil;

import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.FlxState;
import flixel.FlxSprite;

class Fade extends FlxSprite
{
	override public function new(?isStartIn:Bool)
	{
		super(0, isStartIn ? -1500 : 0);
		this.loadGraphic('assets/images/fade.png');
	}

	public function goIn(?nextState:FlxState)
	{
		FlxTween.tween(this, {y: 0}, 2, {
			onComplete: (x) ->
			{
				if (nextState != null)
					FlxG.switchState(nextState);
			}
		});
	}

	public function goOut()
	{
		FlxTween.tween(this, {y: -1500}, 2);
	}
}
