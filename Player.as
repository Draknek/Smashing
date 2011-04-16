package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Player extends CircleEntity
	{
		public var holdX:Number = 0;
		public var holdY:Number = 0;
		
		public var move:Function;
		public var aim:Function;
		
		public function Player ()
		{
			x = 320;
			y = 240;
			
			radius = 12;
			
			move = movementFunction2();
			aim = aimingFunction3();
		}
		
		public override function update (): void
		{
			move();
			aim();
		}
		
		public override function render (): void
		{
			Draw.circlePlus(x, y, radius, 0xFF0000);
			Draw.circlePlus(x+holdX, y+holdY, 2, 0x000000);
		}
		
		// Player moves with mouse
		private function movementFunction1 (): Function
		{
			const FRICTION:Number = 0.5;
			
			return function ():void
			{
				x += (Input.mouseX - x) * 0.5;
				y += (Input.mouseY - y) * 0.5;
			}
		}
		
		// Player walks towards mouse
		private function movementFunction2 (): Function
		{
			const WALK_SPEED:Number = 3;
			const player:Player = this;
			
			return function ():void
			{
				FP.stepTowards(player, Input.mouseX, Input.mouseY, WALK_SPEED);
			}
		}
		
		// Swing dependent on player position
		private function aimingFunction1 (): Function
		{
			return function ():void
			{
				holdX = 0;
				holdY = 0;
			}
		}
		
		// Hand points towards mouse
		private function aimingFunction2 (): Function
		{
			const holdDistance:Number = radius * 2.5;
			
			return function ():void
			{
				var dx:Number = Input.mouseX - x;
				var dy:Number = Input.mouseY - y;
				var dz:Number = Math.sqrt(dx*dx + dy*dy);
			
				if (dz < 0.01) return;
			
				holdX += (holdDistance * dx/dz - holdX) * 0.2;
				holdY += (holdDistance * dy/dz - holdY) * 0.2;
			}
		}
		
		// Hand is distance to mouse scaled
		private function aimingFunction3 (): Function
		{
			const SCALE:Number = 0.15;
			
			return function ():void
			{
				var dx:Number = Input.mouseX - x;
				var dy:Number = Input.mouseY - y;
			
				holdX += (dx*SCALE - holdX) * 0.2;
				holdY += (dy*SCALE - holdY) * 0.2;
			}
		}
	}
}

