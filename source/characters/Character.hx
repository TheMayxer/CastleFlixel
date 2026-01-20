package characters;

import flixel.FlxSprite;
import flixel.util.FlxDestroyUtil;

class Character extends FlxSprite
{
    public var health:Int;
    public var image:String;
    public var accelerationY:Float;

    public function new(x:Float,y:Float, image:String, health:Int,  ?accelerationY:Float = 1500) {
        super(x,y);

        this.image = image;
        this.accelerationY = accelerationY;
        this.health = health;
        loadGraphic(Paths.image('characters/$image'));
        acceleration.y = accelerationY;
    }


    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}