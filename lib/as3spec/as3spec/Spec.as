package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.system.*;

	public class Spec extends EventDispatcher
	{
		private var context:Context;

		// context
		public function describe (context:*, block:Function) :void
		{
			this.context = new Context(context);
			this.context.describe(block);
			System.exit(0);
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
