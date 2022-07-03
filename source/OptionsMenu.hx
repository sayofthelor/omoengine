package;

import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
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
	var curSelected:Int = 0;

	var spriteGroup:FlxSpriteGroup;
	var alphabetGroup:FlxTypedGroup<Alphabet>;
	var checkmarkGroup:FlxTypedGroup<Checkmark>;

	var menus:Map<String, Array<Array<String>>> = [];
	var textValueMap:Map<String, String> = [];
	var textCheckmarkMap:Map<String, Checkmark> = [];

	public var curMenu:String;
	public var curOptions:Array<String> = [];

	public function new() {
		super();
	
		menus["Menu"] = [
			["Gameplay", null, "menu"],
			["HUD", null, "menu"]
		];

		menus["Gameplay"] = [
			["Downscroll", "downscroll", "bool"],
			["Middlescroll", "middlescroll", "bool"], 
			["Ghost Tapping", "ghostTapping", "bool"]
		];

		menus["HUD"] = [
			["Hide Opponent HUD", "hideOpponentNotes", "bool"]
		];
	}

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

		alphabetGroup = new FlxTypedGroup<Alphabet>();
		checkmarkGroup = new FlxTypedGroup<Checkmark>();

		add(alphabetGroup);
		add(checkmarkGroup);

		spriteGroup = new FlxSpriteGroup();

		loadMenu("Menu");

		alphabetTween();

		super.create();
	}

	function loadMenu(menu:String) {
		curMenu = menu;
		trace(curMenu);
		var data = menus[menu];
		trace(data);

		alphabetGroup.clear();
		checkmarkGroup.clear();
		spriteGroup.clear();

		curOptions = [];

		for (s in data) {
			curOptions.push(s[1]);
			makeText(s[0], s[1], s[2] == "bool");
		}
	}

	function makeText(text:String, value:String, isBool:Bool = false) {
		var alphabet = new Alphabet(0, 0, text);
		alphabet.setPosition(60, 160);
		if (alphabetGroup.length > 0) {
			alphabet.y = 160 + alphabetGroup.length * 120;
		}
		alphabetGroup.add(alphabet);
		spriteGroup.add(alphabet);
		if (isBool) {
			var checkmark = new Checkmark(alphabet.x + alphabet.width + alphabet.width / 2, alphabet.y, value);
			checkmark.scale.set(.7, .7);
			checkmarkGroup.add(checkmark);
			spriteGroup.add(checkmark);
			textCheckmarkMap.set(alphabet.text, checkmark);
		}
	}

	function changeValue(text:String, type:String = "bool") {
		switch (type) {
			case "bool":
				var checkmark = textCheckmarkMap.get(text);
				trace("1", Reflect.getProperty(Prefs, checkmark.variable));
				Reflect.setProperty(Prefs, checkmark.variable, !Reflect.getProperty(Prefs, checkmark.variable));
				checkmark.checked = Reflect.getProperty(Prefs, checkmark.variable);
				trace("2", Reflect.getProperty(Prefs, checkmark.variable));
			case "menu":
				for (i in menus["Menu"]) {
					if (i[0] == text) {
						loadMenu(text);
					}
				}
		}

		alphabetTween();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.UP) {
			curSelected--;
			if (curSelected < 0) curSelected = curOptions.length - 1;
			alphabetTween();
		} else if (FlxG.keys.justPressed.DOWN) {
			curSelected++;
			if (curSelected == curOptions.length) curSelected = 0;
			alphabetTween();
		}

		if (FlxG.keys.justPressed.ENTER) {
			var stuff = menus[curMenu];
			for (i in stuff) {
				if (alphabetGroup.members[curSelected].text == i[0]) {
					changeValue(i[0], i[2]);
					save();
				}
			}
		}

		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new MainMenuState());
	}
	function alphabetTween() {
		var data = menus[curMenu];
		for (i in alphabetGroup.members) {
				if (i.text == data[curSelected][0]) {
					FlxTween.tween(i, {x: 100}, .1);
				} else {
					FlxTween.tween(i, {x: 60}, .1);
				}
		}
	}

	function save() {
		Prefs.save();	
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
