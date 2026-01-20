package mapas;

import characters.Lobao;
import characters.Player;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Exterior extends MapaMainState
{
    
    var enemyHealth:Int = 10;
    var lobao:Lobao;

    public function new() {
        super(
            'exterior',
            ['fundo','castelo','arvores-bemproxima','layer-paredes'],
            ['arvores-fundo','castelo-fundo','arvore-muitoproxima','parede_chao'],
            3,
            new FlxPoint(100,400)
        );
    }

    override function create() {

        FlxG.camera.bgColor = FlxColor.fromInt(0xFF1A1224);
        var nuvens = new FlxBackdrop(Paths.image('mapas/exterior/nuvem'),X,1.5);
        nuvens.velocity.x = -100;
        add(nuvens);
        
        super.create();

        lobao = new Lobao(0,0);
		lobao.setPosition(FlxG.width - lobao.width * 2, FlxG.height*0.2);
		add(lobao);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if(lobao.alive)
        {
            FlxG.collide(lobao,objectsMapGroup.members[objectToCollide]);
            cachorraoMoviments(elapsed);
            lobao.scale.set(FlxMath.lerp(lobao.scale.x, 1, elapsed*7),FlxMath.lerp(lobao.scale.y, 1, elapsed*7));
            FlxG.overlap(player,lobao,function(player:Player, lobao:Lobao) {
			    if (player.podeLevarDano)
			    { 
                    healthDamageText(player, 10);
				    player.health -= 10;
				    player.scale.set(FlxG.random.float(0.8,1.2),FlxG.random.float(0.8,1.2));
				    FlxTween.cancelTweensOf(player);
				    FlxTween.color(player,0.7, FlxColor.RED, FlxColor.WHITE);
				    player.podeLevarDano = false;
				    new FlxTimer().start(1,(_)->player.podeLevarDano = true);
			    }
		    });
        }

        if(lobao.health <= 0 && lobao.alive)
            lobao.kill();

        for(arma in armasGroup.members)
		{
			if(arma.overlaps(lobao) && lobao.alive)
			{
				if(arma.name != 'espada')
				{
					if(!arma.deuDano)
					{
						cachorroDanoStuff(arma);
						if(arma.name == "faquinha")
							arma.destroy();
					}
				} else {
					if (arma.visible && !arma.deuDano)
						cachorroDanoStuff(arma);
				}
			}
		}   
    }

    function cachorraoMoviments(e:Float) {

		var cachorraoVelocity:Float = 0;
        if(!lobao.lobaoFicaParado)
        {
            if(lobao.x < player.x)
            cachorraoVelocity = 200;
		        else if (lobao.x > player.x)
                cachorraoVelocity = -200;
		    else 
                cachorraoVelocity = 0;
        }
		
        lobao.velocity.x = cachorraoVelocity;

		lobao.flipX = player.x > lobao.x;
	}

    function cachorroDanoStuff(arma:ArmaLetal) {
        healthDamageText(lobao, arma.dano);
		lobao.health -= arma.dano;
		lobao.lobaoPodeLevarDano = false;
		arma.deuDano = lobao.lobaoFicaParado= true;

		lobao.scale.set(FlxG.random.float(0.8,1.2),FlxG.random.float(0.8,1.2));
		FlxTween.cancelTweensOf(lobao);
		FlxTween.color(lobao,0.7, FlxColor.RED, FlxColor.WHITE);
		new FlxTimer().start(0.5,(_)->lobao.lobaoFicaParado = false);
		new FlxTimer().start(1,(_)->lobao.lobaoPodeLevarDano = true);
	}
}