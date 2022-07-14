package;

import flixel.FlxSprite;

class Checkmark extends FlxSprite {
   
    public var checked(default, set):Bool = false;
    public var variable:String;
    public var doAnims:Bool = false;

    public function new(?x:Float, ?y:Float, variable:String) {
        super(x, y);
        this.variable = variable;

        frames = Paths.getSparrowAtlas('Checkmark', 'preload');

        animation.addByPrefix("checked", "Check Instanz", 0, false);
        animation.addByPrefix("checking", "Checking Instanz", 24, false);
        animation.addByPrefix("unchecked", "No check Instanz", 0, false);

        checked = Reflect.getProperty(Prefs, variable);
    }

    override function update(elapsed:Float) {

        if (animation.curAnim == null) {
            if (Reflect.getProperty(Prefs, variable)) {
                animation.play("checked");
                trace('sex');
            } else {
                animation.play("unchecked");
                trace('sex2');
            }
        }

        if (doAnims) {
        if (Reflect.getProperty(Prefs, variable)) {
            animation.play("checking", true, false);
            offset.set(19, 10);
        } else {
            animation.play("checking", true, true);
            offset.set(19, 10);
        }
    }

        if (animation.curAnim != null) {
            if (animation.curAnim.name == "checking") {
                if (checked && animation.curAnim.finished) {
                    animation.play("checked");
                    // offset.set(19, 10); // cant find the correct offset values fml
                } else if (!checked && animation.curAnim.curFrame <= 0) {
                    animation.play("unchecked");
                    // offset.set(19, 10); // cant find the correct offset values fml
                }
            }
        }
        
        super.update(elapsed);
    }

    function set_checked(value:Bool) {
        if (checked == value) return checked;

        Reflect.setProperty(Prefs, variable, value);

        if (animation.curAnim == null) {
            if (value) {
                animation.play("checked");
                trace('sex');
            } else {
                animation.play("unchecked");
                trace('sex2');
            }

            return checked = value;
        }

        if (value) {
            animation.play("checking", true, false);
            offset.set(19, 10);
        } else {
            animation.play("checking", true, true);
            offset.set(19, 10);
        }
        return checked = value;
    }
}