package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxDestroyUtil;

class ArmaLetal extends FlxSprite
{
    public var dano:Int;
    public var deuDano:Bool = false;
    public var name:String;

    public function new(name:String, dano:Int) {
        super();
        this.name = name;
        this.dano = dano;

        if(name!="espada")
            loadGraphic(Paths.image('armas/$name'));
        else {
            frames = FlxAtlasFrames.fromSparrow(Paths.image('armas/$name/$name'), Paths.xml('images/armas/$name/$name'));
            animation.addByPrefix('attack','attack0',24,false);
            //deveria ter uma lei, pode molestar o GuineaPigUhh
        }

        updateHitbox();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}