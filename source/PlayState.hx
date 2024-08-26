package;

import flixel.*;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import haxe.Timer;

class PlayState extends FlxState
{
	var cameraHUD:FlxCamera;

	var isGameover:Bool = false;

	var firstUpdate:Bool = true;
	var countState:Int = 0;

	var inputKeys:Array<FlxKey> = ['SPACE'];

	var songInst:FlxSound;

	var throwSound:FlxSound;

	var bob:TowSprite;
	var bosip:TowSprite;
	var BG:Background;

	var gameoverBlack:FlxSprite;

	var birdList:FlxTypedSpriteGroup<Bird>;

	var songJson:SongJson;
	var songPath = 'LoveBirds';

	var offset:Int = 0;
	// Sick, Good, Ok, Bad, Shit
	var ratingSprite:FlxTypedSpriteGroup<RatingSprite>;
	//* I coppied this into SongFinishedSubState so be careful
	var rankings = [15, 25, 40, 100];
	var rankList:Array<Rank> = [];
	var rankNames = ["sick", "good", "Bad", "Shit"];

	var healthBar:FlxBar;
	var healthBG:FlxSprite;
	var healthP1:HealthIcon;
	var healthP2:HealthIcon;

	/*
		TODO: Add end-screen
		TODO: Credits
		TODO: Freeplay
		TODO: Clean up

	 */
	override public function create()
	{
		super.create();

		songPath = StaticVar.nextSong;
		songJson = TowPaths.getFile('songs/' + songPath + '/chart', JSON, false);
	}
}
