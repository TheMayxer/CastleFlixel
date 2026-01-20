/*package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var player:FlxSprite;
	var chao:FlxSprite;
	var cachorrao:FlxSprite;
	var espada:ArmaLetal;
	var mapLoader:FlxOgmo3Loader;
	var chaoTile:FlxTilemap;
	var paredeTile:FlxTilemap;

	var armasGroup:FlxTypedGroup<ArmaLetal>;

	var cachorraoPodeLevarDano:Bool = true;
	
	var cachorraoFicaParado:Bool = false;

	var playerHealth:Int = 30;
	var enemyHealth:Int = 30;

	override public function create()
	{
		FlxG.camera.bgColor = FlxColor.fromInt(0xFF1A1224);

		var nuvem = new FlxBackdrop(Paths.image('mapas/exterior/nuvem'),X,1.0);
		nuvem.velocity.x = -100;
		add(nuvem);

		mapLoader = new FlxOgmo3Loader(Paths.ogmo('exterior'),Paths.json('exterior'));

		var arvores = mapLoader.loadTilemap(Paths.image('mapas/exterior/arvores-fundo'),'fundo');
		add(arvores);

		var castelos = mapLoader.loadTilemap(Paths.image('mapas/exterior/castelo-fundo'),'castelo');
		add(castelos);

		paredeTile = mapLoader.loadTilemap(Paths.image('mapas/exterior/parede_chao'),'layer-paredes');
		paredeTile.immovable = true;
		add(paredeTile);

		player = new FlxSprite(200,0,Paths.image('andrezitos'));
		player.acceleration.y = 1500;
		player.velocity.y = 0;
		add(player);

		cachorrao = new FlxSprite(0,0,Paths.image('cachorrao'));
		cachorrao.setPosition(FlxG.width - cachorrao.width * 2, FlxG.height*0.6);
		add(cachorrao);

		armasGroup = new FlxTypedGroup<ArmaLetal>();
		add(armasGroup);

		espada = new ArmaLetal('espada',2);
		espada.visible = false;
		armasGroup.add(espada);
		espada.animation.onFinish.add(function(animName:String) {
			espada.visible = false;
			espada.deuDano = false;
			espada.updateHitbox();
		});

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player,paredeTile);
		//FlxG.collide(player,chaoTile);
		

		FlxG.overlap(player,cachorrao,function(player:FlxSprite, cachorrao:FlxSprite) {
			if (playerPodeLevarDano)
			{ 
				playerHealth -= 25;
				player.scale.set(FlxG.random.float(0.8,1.2),FlxG.random.float(0.8,1.2));
				FlxTween.cancelTweensOf(player);
				FlxTween.color(player,0.7, FlxColor.RED, FlxColor.WHITE);
				playerPodeLevarDano = false;
				new FlxTimer().start(1,(_)->playerPodeLevarDano = true);
			}
		});

		for(arma in armasGroup.members)
		{
			if(arma.overlaps(cachorrao))
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

		for(bixo in [cachorrao, player])
			bixo.scale.set(FlxMath.lerp(bixo.scale.x,1,elapsed*7),FlxMath.lerp(bixo.scale.y,1,elapsed*7));

		playerMoviments(elapsed);
		cachorraoMoviments(elapsed);
		tacarMachado();

		espada.setPosition((player.flipX ? player.x-60 : player.x+60), player.y+player.height/2 - espada.height/2);
		espada.flipX = player.flipX;
		abaterComEspada();
	}

	

	function cachorraoMoviments(e:Float) {
		if(!cachorraoFicaParado)
		{
			final cachorraoVelocity:Float = 100;
			if(cachorrao.x < player.x)
				cachorrao.x += cachorraoVelocity*e*2;
			else if (cachorrao.x > player.x)
				cachorrao.x -= cachorraoVelocity*e*2;
			else 
				cachorrao.x = player.x;

			cachorrao.flipX = player.x > cachorrao.x;
		}
	}

	

	function cachorroDanoStuff(arma:ArmaLetal) {
		enemyHealth -= arma.dano;
		cachorraoPodeLevarDano = false;
		arma.deuDano = cachorraoFicaParado = true;

		cachorrao.scale.set(FlxG.random.float(0.8,1.2),FlxG.random.float(0.8,1.2));
		FlxTween.cancelTweensOf(cachorrao);
		FlxTween.color(cachorrao,0.7, FlxColor.RED, FlxColor.WHITE);
		new FlxTimer().start(0.5,(_)->cachorraoFicaParado = false);
		new FlxTimer().start(1,(_)->cachorraoPodeLevarDano = true);
	}
}
*/