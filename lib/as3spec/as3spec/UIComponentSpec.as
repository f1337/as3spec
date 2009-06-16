package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.system.*;
	import mx.core.*;

	public class UIComponentSpec extends Spec
	{
		private var context:UIComponent;
		private var block:Function;

		// redirect describe until after creationComplete
		override public function describe (context:*, block:Function) :void
		{
			if (context is UIComponent)
			{
				this.context = (context as UIComponent);
				this.block = block;
				this.context.addEventListener('creationComplete', do_describe);

				Application.application.addChild(this.context);
			}
			else
			{
				do_describe();
			}
		}

		private function do_describe (...args) :void
		{
			super.describe(this.context.className, this.block);
		}
	}
}
