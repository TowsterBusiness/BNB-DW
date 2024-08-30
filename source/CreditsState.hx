package;

import flixel.FlxSprite;
import flixel.FlxState;
import towsterFlxUtil.TowPaths;

class CreditsState extends FlxState
{
	var BG:FlxSprite;

	override function create()
	{
		super.create();

		BG = new FlxSprite(0, 0).loadGraphic(TowPaths.getFilePath('menus/menuBGPurple', PNG));
		add(BG);
	}
}
