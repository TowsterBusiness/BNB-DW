package;

import towsterFlxUtil.TowSprite;

class DialogueCharacter extends TowSprite
{
	public var id:String = null;

	public function new(id:String)
	{
		this.id = id;
		switch (id)
		{
			case 'bob':
				super(720, 120, 'dialogue/bob_portraits');
				animation.addByPrefix('WHAT', 'bob portrait WHAT0', 24, false);
				animation.addByPrefix('disappointed', 'bob portrait disappointed0', 24, false);
				animation.addByPrefix('embarrassed', 'bob portrait embarrassed', 24, false);
				animation.addByPrefix('happy', 'bob portrait happy0', 24, false);
				animation.addByPrefix('pouting', 'bob portrait pouting0', 24, false);
				animation.addByPrefix('regular', 'bob portrait regular0', 24, false);
				animation.addByPrefix('sleepy', 'bob portrait sleepy0', 24, false);
				playAnim('regular');
			case 'bosip':
				super(280, 120, 'dialogue/bosip_portraits');
				animation.addByPrefix('WHAT', 'bosip portrait WHAT0', 24, false);
				animation.addByPrefix('annoyed', 'bosip portrait annoyed0', 24, false);
				animation.addByPrefix('embarrassed', 'bosip portrait embarrassed', 24, false);
				animation.addByPrefix('happy', 'bosip portrait happy0', 24, false);
				animation.addByPrefix('confused', 'bosip portrait confused0', 24, false);
				animation.addByPrefix('regular', 'bosip portrait regular0', 24, false);
				animation.addByPrefix('sad', 'bosip portrait sad0', 24, false);
				playAnim('regular');
		}
	}
}
