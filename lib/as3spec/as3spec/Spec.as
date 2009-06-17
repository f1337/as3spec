package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.system.*;

	public class Spec extends EventDispatcher
	{
		private var context:Context;

		// context
/*		describe (context:*, story:String, block:Function) */
/*		describe (context:*, block:Function) */
/*		describe (story:String, block:Function) */
		public function describe (...args) :void
		{
			if (args.length < 2) throw('invalid arguments for describe()');

			var block:Function = (args.pop() as Function);
			if (block == null) throw('describe() expects function() block');

			var context:String = args.join(' ');

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
