package;

import openfl.text.StaticText;
import flixel.tweens.FlxTween;
import towsterFlxUtil.TowSprite;
import towsterFlxUtil.TowUtils;
import flixel.FlxSprite;
import towsterFlxUtil.TowPaths;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxState;

typedef DialogueTextJson =
{
	character:String,
	anim:String,
	text:String
}

class DialogueState extends FlxState
{
	var id:String = 'day';

	var textNum:Int = 0;

	var songPath:String = 'LoveBirds';
	var dialogueJson:Array<DialogueTextJson>;

	var characterList:FlxTypedSpriteGroup<DialogueCharacter>;
	var BG:Background;
	var dialogueBox:TowSprite;
	var dialogueText:DialogueText;

	var bob:TowSprite;
	var bosip:TowSprite;

	override function create()
	{
		super.create();

		FlxG.sound.music.volume = 0;

		// TODO add music in the background

		songPath = StaticVar.nextSong;
		dialogueJson = TowPaths.getFile('songs/' + songPath + '/dialogue', JSON, false).dialogue;

		characterList = new FlxTypedSpriteGroup(0, 0, 100);

		switch (id)
		{
			case 'day':
				BG = new Background('day');
				add(BG);
				characterList.add(new DialogueCharacter('bosip'));
		}

		add(characterList);

		bob = new TowSprite(675, 190, 'characters/bob_assets');
		bob.loadAnimations('characters/bob');
		bob.scale.set(0.5, 0.5);
		bob.playAnim('idle');
		bob.updateHitbox();

		bosip = new TowSprite(500, 150, 'characters/bosip_assets');
		bosip.loadAnimations('characters/bosip');
		bosip.scale.set(0.5, 0.5);
		bosip.playAnim('idle');
		bosip.updateHitbox();

		add(bob);
		add(bosip);

		dialogueBox = new TowSprite(0, 400, 'dialogue/dialogue_box');
		dialogueBox.animation.addByPrefix('start', 'dialogue box anim0', 24, false);
		dialogueBox.playAnim('start');
		dialogueBox.screenCenter(X);
		add(dialogueBox);

		dialogueText = new DialogueText();
		add(dialogueText);
		newText(0);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([ENTER, SPACE]))
		{
			if (!dialogueText.isFinished())
			{
				dialogueText.finish();
			}
			else if (textNum + 1 < dialogueJson.length)
			{
				textNum++;
				newText(textNum);
			}
			else
			{
				FlxG.switchState(new PlayState());
			}
		}

		if (!dialogueText.isFinished())
		{
			playCharAnim();
		}
	}

	function newText(num:Int)
	{
		var dialogueSecJson:DialogueTextJson = dialogueJson[num];
		dialogueText.nextText(dialogueSecJson.text);
		characterList.forEachAlive(function(char)
		{
			if (char.id != dialogueSecJson.character)
				return;

			char.playAnim(dialogueSecJson.anim);
			dialogueBox.playAnim('start');
			characterList.alpha = 0;
			FlxTween.tween(characterList, {alpha: 1}, 0.2);
		});
	}

	function playCharAnim()
	{
		var dialogueSecJson:DialogueTextJson = dialogueJson[textNum];
		characterList.forEachAlive(function(char)
		{
			if (char.id == dialogueSecJson.character && char.animation.finished)
				char.playAnim(dialogueSecJson.anim);
		});
	}
}
