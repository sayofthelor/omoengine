package;

import flixel.FlxG;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite {

    public var data:Int;

    public function new() {
        super(x, y);
    }

    public function setup(x:Float = 0, y:Float = 0, data:Int) {
        this.data = data;

        loadAnims();
        offset.set(10, 10);

        setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
    
        var randomNum = FlxG.random.int(1, 2);
        animation.play('note$data-$randomNum', true);
        animation.curAnim.frameRate = FlxG.random.int(22, 26);
    }

    public function loadAnims(?skin:String = null, ?library:String = 'preload') {
        frames = skin != null ? Paths.getSparrowAtlas(skin, library) : Paths.getSparrowAtlas('noteSplashes', library);
        for (i in 1...3)
            animation.addByPrefix('note$data-$i', 'note splash ${StaticArrow.colorArray[data]} $i', 24, false);
    }

    override function update(elapsed:Float) {
        if (animation.curAnim != null && animation.curAnim.finished) {
            kill();
        }
        super.update(elapsed);
    }
}