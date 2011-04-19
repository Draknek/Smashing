package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	import flash.geom.Point;
	
	public class Player extends CircleEntity
	{
		public var holdX:Number = 0;
		public var holdY:Number = 0;
		
		public var moveUpdate:Function;
		public var aimUpdate:Function;
		
		public var moveRender:Function;
		public var aimRender:Function;
		
		public const JOYSTICK_RADIUS:Number = 50;
		
		// This is the center of the virtual control stick if applicable, null otherwise
		public var moveCenter:Point;
		public var aimCenter:Point;
		
		public function Player ()
		{
			x = 320;
			y = 240;
			
			radius = 12;
			
			movementFunctionJoystick();
			aimingFunctionJoystick();
		}
		
		public override function update (): void
		{
			moveUpdate();
			aimUpdate();
		}
		
		public override function render (): void
		{
			if (moveRender != null) moveRender();
			if (aimRender != null) aimRender();
			Draw.circlePlus(x, y, radius, 0xFF0000);
			Draw.circlePlus(x+holdX, y+holdY, 2, 0x000000);
		}
		
		// *** MOVEMENT OPTIONS *** //
		
		// Player moves with mouse
		private function movementFunctionMouse (): void
		{
			const FRICTION:Number = 0.5;
			
			moveUpdate = function ():void
			{
				x += (Input.mouseX - x) * 0.5;
				y += (Input.mouseY - y) * 0.5;
			}
		}
		
		// Player walks towards mouse
		private function movementFunctionWalking (): void
		{
			const WALK_SPEED:Number = 3;
			const player:Player = this;
			
			moveUpdate = function ():void
			{
				FP.stepTowards(player, Input.mouseX, Input.mouseY, WALK_SPEED);
			}
		}
		
		// Virtual control stick
		private function movementFunctionJoystick (): void
		{
			const WALK_SPEED:Number = 3;
			const player:Player = this;
			
			moveUpdate = function ():void
			{
				if (Input.mousePressed && Input.mouseX < FP.halfWidth) {
					moveCenter = new Point(Input.mouseX, Input.mouseY);
				} else if (! Input.mouseDown) {
					moveCenter = null;
				} else if (moveCenter) {
					FP.point.x = Input.mouseX - moveCenter.x;
					FP.point.y = Input.mouseY - moveCenter.y;
					
					var l:Number = FP.point.length;
					
					if (l > JOYSTICK_RADIUS) l = JOYSTICK_RADIUS;
					
					l *= WALK_SPEED / JOYSTICK_RADIUS;
					
					FP.point.normalize(l);
					
					x += FP.point.x;
					y += FP.point.y;
				}
			}
			
			renderFunctionJoystick("move");
		}
		
		// *** AIMING OPTIONS *** //
		
		// Swing dependent on player position
		private function aimingFunctionNone (): void
		{
			aimUpdate = function ():void
			{
				holdX = 0;
				holdY = 0;
			}
		}
		
		// Hand is distance to mouse scaled
		private function aimingFunctionMouse (): void
		{
			const SCALE:Number = 0.15;
			
			aimUpdate = function ():void
			{
				var dx:Number = Input.mouseX - x;
				var dy:Number = Input.mouseY - y;
			
				holdX += (dx*SCALE - holdX) * 0.2;
				holdY += (dy*SCALE - holdY) * 0.2;
			}
		}
		
		// Virtual control stick
		private function aimingFunctionJoystick (): void
		{
			const SCALE:Number = 0.15;
			
			aimUpdate = function ():void
			{
				if (Input.mousePressed && Input.mouseX >= FP.halfWidth) {
					aimCenter = new Point(Input.mouseX, Input.mouseY);
				} else if (! Input.mouseDown) {
					aimCenter = null;
					holdX *= 0.99;
					holdY *= 0.99;
				} else if (aimCenter) {
					var dx:Number = Input.mouseX - aimCenter.x;
					var dy:Number = Input.mouseY - aimCenter.y;
			
					holdX += (dx*SCALE - holdX) * 0.2;
					holdY += (dy*SCALE - holdY) * 0.2;
				}
				
			}
			
			renderFunctionJoystick("aim");
		}
		
		// *** Rendering for joysticks *** //
		
		private function renderFunctionJoystick (param:String):void
		{
			this[param + "Render"] = function ():void
			{
				var p:Point = this[param + "Center"];
				
				if (p) {
					Draw.circlePlus(p.x, p.y, JOYSTICK_RADIUS, 0x0088FF, 0.3);
				}
			}
		}
	}
}

