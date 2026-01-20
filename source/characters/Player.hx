package characters;

import flixel.FlxG;

class Player extends Character
{
    public var temMachado:Bool = true;
    public var temEspada:Bool = true;
	public var podeTacaOMachado:Bool = true;
    public var podeLevarDano:Bool = true;
	public var podeAtacarComEspada:Bool = true;

    public function new(x:Float, y:Float) {
        super(x,y,'andrezitos',100);
    }
    override function update(elapsed:Float) {
        super.update(elapsed);
    
    }
}