package backend;

import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.FlxG;
import openfl.Lib;
import openfl.system.System;
import flixel.math.FlxMath;

// lore.FPS but funnier lmao

using StringTools;

// Credits to OpenFL repository for the original code
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class FPS extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;
	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;
	
	public function new(?x:Float = 3, ?y:Float = 3, ?color:Int = 0xFFFFFF)
	{
		super();

		this.x = x;
		this.y = y;
		width = FlxG.width;
		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("VCR OSD Mono", 12, color);
		text = "0 FPS";

		cacheCount = 0;
		currentTime = 0;
		times = [];
	}

	// Event Handlers
	@:noCompletion
	private override function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		var memoryMegas = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 1));

		if (currentCount != cacheCount /*&& visible*/)
		{
			text =
			currentFPS + " FPS" +
            "Current State: " + FlxG.state +
			"\nMemory: " + memoryMegas + " MB"
			#if debug + "\n(debug)" #end;
		}

		cacheCount = currentCount;
	}
}
