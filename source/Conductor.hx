package;

import JsonTypes;
import haxe.Timer;

class Conductor
{
	var bpmJson:Array<BPMJson>;
	var startTime:Int;

	var pauseStartTime:Int = 0;
	var pauseCounter:Int = 0;
	var isPause:Bool = false;

	var nextBeatCheck:Float = 0;
	var beatCheckBPM:BPMJson = null;

	public function new(bpmJson:Array<BPMJson>, ?startDelay:Int = 0)
	{
		this.bpmJson = bpmJson;
		startTime = getRawMil() - startDelay;
	}

	public function getMil():Int
	{
		if (isPause)
			return getRawMil() - (startTime + pauseCounter + (getRawMil() - pauseStartTime));

		return getRawMil() - (startTime + pauseCounter);
	}

	public function getBPM():BPMJson
	{
		var returnBpm:BPMJson = {time: -9999999, bpm: 120};
		var beenChanged:Bool = false;
		for (bpm in bpmJson)
		{
			if (getMil() >= bpm.time && bpm.time > returnBpm.time)
			{
				returnBpm = bpm;
				beenChanged = true;
			}
		}
	}
}
