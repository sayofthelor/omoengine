package objects;

import flixel.FlxSprite;

class StaticArrow extends FlxSprite {

    public var data:Int;

    public function new(x:Float = 0, y:Float = 0, data:Int):Void {
        super(x, y);
        reload(data);
    }

    public function reload(data:Int):Void {
        this.data = data; 
        if (PlayState.curStage == 'school' || PlayState.curStage == 'schoolEvil')
            return loadPixelWeekSkin(data);
        loadDefaultSkin(data);
    }

    public function loadPixelWeekSkin(data:Int):Void {
        loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels', 'week6'), true, 17, 17);

        animation.add('green', [6]);
        animation.add('red', [7]);
        animation.add('blue', [5]);
        animation.add('purplel', [4]);

        animation.add('static', [data], 0);
        animation.add('pressed', [4+data, 8+data], 12, false);
        animation.add('confirm', [12+data, 16+data], 24, false);     
        
        x += Note.swagWidth * data;

        setGraphicSize(Std.int(width * PlayState.daPixelZoom));
        antialiasing = false;

        animation.play('static');
    }

    public static var directionArray:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
    public static var colorArray:Array<String> = ['purple', 'blue', 'green', 'red'];

    public function loadDefaultSkin(data:Int):Void {
        frames = Paths.getSparrowAtlas('NOTE_assets');

        animation.addByPrefix(colorArray[data], 'arrow${directionArray[data]}');

        animation.addByPrefix('static', 'arrow${directionArray[data]}');
        animation.addByPrefix('pressed', '${directionArray[data].toLowerCase()} press', 24, false);
        animation.addByPrefix('confirm', '${directionArray[data].toLowerCase()} confirm', 24, false);
    
        x += Note.swagWidth * data;

        setGraphicSize(Std.int(width * 0.7));
        antialiasing = true;

        animation.play('static');
    }
}