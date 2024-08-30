package;

import towsterFlxUtil.TowSprite;

class HealthIcon extends TowSprite
{
	public function new(x:Float, y:Float, id:String = 'bosip', isP1:Bool = true)
	{
		super(x, y, 'icons/' + id + '-icon', true);
		playAnim('happy');
		flipX = isP1;
		antialiasing = true;
	}
}
