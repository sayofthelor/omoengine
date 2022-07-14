package utils;

import flixel.FlxG;

class Prefs {
    public static var downscroll:Bool = true;
    public static var middlescroll:Bool = true;
    public static var ghostTapping:Bool = true;
    public static var hideOpponentNotes:Bool = true;
    public static var noteSplashes:Bool = true;

    public static function save() {
        FlxG.save.data.downscroll = downscroll;
        FlxG.save.data.middlescroll = middlescroll;
        FlxG.save.data.ghostTapping = ghostTapping;
        FlxG.save.data.hideOpponentNotes = hideOpponentNotes;

        FlxG.save.flush();
    }

    public static function load() {
        downscroll = FlxG.save.data.downscroll;
        middlescroll = FlxG.save.data.middlescroll;
        ghostTapping = FlxG.save.data.ghostTapping;
        hideOpponentNotes = FlxG.save.data.hideOpponentNotes;
    }
}