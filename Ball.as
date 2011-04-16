package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class Ball extends CircleEntity
	{
		[Embed(source="images/SpikeBall.png")] public static const Gfx: Class;
		
		public var player:Player;
		
		public var image:Image;
		
		public var minLength:Number;
		
		public const ELASTIC:Number = 0.04;
		public const FRICTION:Number = 0.1;
		
		public function Ball (p:Player)
		{
			player = p;
			
			x = p.x;
			y = p.y;
			
			image = new Image(Gfx);
			
			graphic = image;
			
			radius = image.height*0.5;
			
			image.originX = 1 + radius*2;
			image.originY = radius;
			
			minLength = radius * 3;
			
			x -= minLength;
		}
		
		public override function update (): void
		{
			var dx:Number = player.x + player.holdX - x;
			var dy:Number = player.y + player.holdY - y;
			
			var dzSq:Number = dx*dx + dy*dy;
			var dz:Number;
			
			if (dzSq < minLength*minLength) {
				dx = 0;
				dy = 0;
			} else {
				dz = Math.sqrt(dzSq);
				
				dx -= minLength*dx/dz;
				dy -= minLength*dy/dz;
			}
			
			var ax: Number = dx * ELASTIC - vx * FRICTION;
			var ay: Number = dy * ELASTIC - vy * FRICTION;
			
			vx += ax;
			vy += ay;
			
			x += vx;
			y += vy;
		}
		
		public override function render (): void
		{
			var tx:Number = player.x + player.holdX;
			var ty:Number = player.y + player.holdY;
			
			var dx:Number = tx - x;
			var dy:Number = ty - y;
			
			var dzSq:Number = dx*dx + dy*dy;
			
			if (dzSq < minLength*minLength) {
				//
			} else {
				image.angle += FP.angleDiff(image.angle, FP.DEG * Math.atan2(dy, dx)) * 0.1;
			}
			
			image.x = Math.cos(image.angle * FP.RAD) * radius;
			image.y = Math.sin(image.angle * FP.RAD) * radius;
			
			Draw.linePlus(tx, ty, x + image.x, y + image.y, 0xFFFFFF);
			
			super.render();
		}
	}
}

