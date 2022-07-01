package;

import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;


	private var grpControls:FlxTypedGroup<Alphabet>;

	var checkmark:Checkmark;

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		// controlsStrings = CoolUtil.coolTextFile(Paths.txt('controls'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		super.create();

		openSubState(new OptionsSubState());

		checkmark = new Checkmark(0, 0, "downscroll");
		add(checkmark);
		checkmark.screenCenter();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER) {
			Reflect.setProperty(Prefs, checkmark.variable, !Reflect.getProperty(Prefs, checkmark.variable));
			checkmark.checked = Reflect.getProperty(Prefs, checkmark.variable);
		}

		/* 
			if (controls.ACCEPT)
			{
				changeBinding();
			}

			if (isSettingControl)
				waitingInput();
			else
			{
				if (controls.BACK)
					FlxG.switchState(new MainMenuState());
				if (controls.UP_P)
					changeSelection(-1);
				if (controls.DOWN_P)
					changeSelection(1);
			}
		 */
	}

	// function waitingInput():Void
	// {
	// 	if (FlxG.keys.getIsDown().length > 0)
	// 	{
	// 		PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxG.keys.getIsDown()[0].ID, null);
	// 	}
	// 	// PlayerSettings.player1.controls.replaceBinding(Control)
	// }

	// var isSettingControl:Bool = false;

	// function changeBinding():Void
	// {
	// 	if (!isSettingControl)
	// 	{
	// 		isSettingControl = true;
	// 	}
	// }
}
