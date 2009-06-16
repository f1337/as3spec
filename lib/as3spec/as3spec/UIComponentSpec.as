package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.system.*;
	import mx.core.UIComponent;

	public class UIComponentSpec extends Spec
	{
		private var context:UIComponent;
		private var block:Function;

		// context
		override public function describe (context:*, block:Function) :void
		{
			if (context is UIComponent)
			{
				this.context = (context as UIComponent);
				this.block = block;
				this.context.addEventListener('creationComplete', after_creation_complete);
				Application.application.addChild(this.context);
			}
			else
			{
				super.describe(context, block);
			}
		}

		// 
		private function after_creation_complete (e:Object) :void
		{
			super.describe(this.context, this.block);
		}

		// specify
		public function it (story:String, block:Function) :void
		{
			context.specify(story, block);
		}

		// require
		public function so (value:*) :Should
		{
			return context.require(value);
		}

	}
}
