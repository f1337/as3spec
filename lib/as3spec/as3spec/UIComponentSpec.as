package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.system.*;
	import mx.core.*;

	public class UIComponentSpec extends Spec
	{
		// redirect describe until after creationComplete
		override public function describe (...args) :void
		{
			if (args[0] is UIComponent)
			{
				var component:UIComponent = (args.shift() as UIComponent);
				args.unshift(component.className);

				component.addEventListener('creationComplete', function () :void
				{
					do_describe(args);
				});
				Application.application.addChild(component);
			}
			else
			{
				do_describe(args);
			}
		}

		private function do_describe (args:Array) :void
		{
			super.describe.apply(null, args);
		}
	}
}
