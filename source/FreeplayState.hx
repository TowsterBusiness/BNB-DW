package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import openfl.utils.Assets as FileSystem;
import towsterFlxUtil.TowPaths;

class FreeplayState extends FlxState
{
	var BG:FlxSprite;

	var songList:FlxTypedSpriteGroup<FlxText>;
	var textSpacing = 30;
	var selectedText = 0;

	override function create()
	{
		super.create();

		BG = new FlxSprite(0, 0).loadGraphic(TowPaths.getFilePath('menus/menuBGBlue', PNG));
		add(BG);

		var songNameList:Array<String> = TowPaths.getFile('songs/songList', JSON, false).songList;

		songList = new FlxTypedSpriteGroup(30, 30, 999);
		add(songList);
		var textOffset = 0;
		for (songName in songNameList)
		{
			var tempText = new FlxText(0, textOffset, 0, songName, 80);
			tempText.font = TowPaths.getFilePath('fonts/Bangers-Regular.ttf');
			songList.add(tempText);

			textOffset += textSpacing;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.UP)
		{
			selectedText++;
			updateSongList();
		}
	}

	function updateSongList()
	{
		songList.y = textSpacing * selectedText + 30;
		songList.forEachAlive((text) ->
		{
			text.scale.set(1, 1);
		});
		songList.members[selectedText].scale.set(1.2, 1.2);
	}
}
