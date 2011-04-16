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
		
		public var holdDistance:Number;
		
		public function Player ()
		{
			x = 320;
			y = 240;
			
			radius = 12;
			
			holdDistance = radius*2.5;
		}
		
		public override function update (): void
		{
			/*var dx:Number = Input.mouseX - x;
			var dy:Number = Input.mouseY - y;
			var dz:Number = Math.sqrt(dx*dx + dy*dy);
			
			const WALK_SPEED:Number = 2;
			
			FP.stepTowards(this, Input.mouseX, Input.mouseY, WALK_SPEED);
			
			if (dz < 0.01) return;
			
			holdX += (holdDistance * dx/dz - holdX) * 0.2;
			holdY += (holdDistance * dy/dz - holdY) * 0.2;*/
			
			x += (Input.mouseX - x) * 0.5;
			y += (Input.mouseY - y) * 0.5;
		}
		
		public override function render (): void
		{
			Draw.circlePlus(x, y, radius, 0xFF0000);
			Draw.circlePlus(x+holdX, y+holdY, 2, 0x000000);
		}
	}
}

