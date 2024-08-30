package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import towsterFlxUtil.TowPaths;

class Background extends FlxTypedSpriteGroup<FlxSprite>
{
	public function new(id:String)
	{
		super(0, 0, 3);

		switch (id)
		{
			case 'day':
				var BG1 = new FlxSprite(0, -10).loadGraphic(TowPaths.getFilePath('bg/day/bg1', PNG));
				var BG2 = new FlxSprite(0, -10).loadGraphic(TowPaths.getFilePath('bg/day/bg2', PNG));
				var BG3 = new FlxSprite(0, -10).loadGraphic(TowPaths.getFilePath('bg/day/bg3', PNG));
				BG1.scale.set(0.67, 0.67);
				BG2.scale.set(0.67, 0.67);
				BG3.scale.set(0.67, 0.67);
				BG1.updateHitbox();
				BG2.updateHitbox();
				BG3.updateHitbox();
				add(BG1);
				add(BG2);
				add(BG3);
		}
	}
}
