package;

import PlayState.Rank;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Timer;
import towsterFlxUtil.TowPaths;

class SongFinishedSubState extends FlxSubState
{
	var blackScreen:FlxSprite;
	var rankList:Array<Rank>;
	var rankings = [15, 25, 40, 100];
	var accuracy:Float;

	var noteText:FlxText;

	var mainMessage:FlxText;
	var dialogueSound:FlxSound;
	var loadedTextPointer:Int = -1;
	var ratingSprite:FlxText;
	var enterText:FlxText;

	public function new(rankList:Array<Rank>)
	{
		this.rankList = rankList;
		super(0x00000000);
	}

	override function create()
	{
		super.create();

		blackScreen = new FlxSprite(0, 0).loadGraphic(TowPaths.getFilePath("blackScreen", PNG));
		blackScreen.alpha = 0;
		add(blackScreen);

		FlxTween.tween(blackScreen, {alpha: 0.95}, 1.5, {ease: FlxEase.sineOut});

		// Calculate the accuracy
		for (rank in rankList)
		{
			var rankNum = getRank(rank.difference);
			switch (rankNum)
			{
				case 0:
					accuracy += 100;
				case 1:
					accuracy += 90;
				case 2:
					accuracy += 80;
				case 3:
					accuracy += 50;
			}
		}
		accuracy /= rankList.length;

		var mainMessageText:String = '';
		var finalRating:String = '';

		if (accuracy >= 100)
		{
			mainMessageText = "WOAH!!! I didn't even think that was possible";
			finalRating = "S";
		}
		else if (accuracy > 95)
		{
			mainMessageText = "Bob will be gracefully sleeping";
			finalRating = "A+";
		}
		else if (accuracy > 90)
		{
			mainMessageText = "You're really good at this!";
			finalRating = "A";
		}
		else if (accuracy > 80)
		{
			mainMessageText = "Good! but bob's starting to wake up...";
			finalRating = "B";
		}
		else if (accuracy > 70)
		{
			mainMessageText = "Alright, you might want to try again";
			finalRating = "C";
		}
		else if (accuracy > 60)
		{
			mainMessageText = "Try Again Please so Bob is happy";
			finalRating = "D";
		}
		else if (accuracy > 50)
		{
			mainMessageText = "Just get good c'mon";
			finalRating = "F";
		}
		else
		{
			mainMessageText = "How??????";
			finalRating = "F-";
		}
	}
}
