package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	public class CircleEntity extends Entity
	{
		public var vx: Number = 0;
		public var vy: Number = 0;
		public var radius: Number = 0;
		
		public function CircleEntity (_x:Number = 0, _y:Number = 0, _radius:Number = 0)
		{
			x = _x;
			y = _y;
			radius = _radius;
		}
		
		public override function update (): void
		{
			x += vx;
			y += vy;
		}
	}
}

