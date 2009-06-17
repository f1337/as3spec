package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.system.*;
	import mx.core.*;

	public class UIComponentSpec extends Spec
	{
		// track setup/teardown to prevent exit() before async specs complete
		static private var counter:uint = 0;

		// redirect describe until after creationComplete
		override public function describe (...args) :void
		{
			counter++;

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
			counter--;
			super.describe.apply(null, args);
		}

		override protected function exit () :void
		{
			exit_ok = (counter == 0);
			super.exit();
		}
	}
}
