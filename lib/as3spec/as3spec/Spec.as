package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.system.*;

	public class Spec extends EventDispatcher
	{
		// LIFO stack: most recent context at [0]
		static private var contexts:Array = [];

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

			contexts.unshift(new Context(context));
			contexts[0].describe(block);

			contexts.shift();
			if (contexts.length == 0) exit();
		}

		// specify
		public function it (story:String, block:Function) :void
		{
			contexts[0].specify(story, block);
		}

		// require
		public function so (value:*) :Should
		{
			return contexts[0].require(value);
		}


		private function exit () :void
		{
			// 50 specifications (380 requirements), 1 failures, 1 errors
			var counter:Object = Specification.counter;
			trace('');
			trace(counter.specifications + ' specifications (' + 
				counter.requirements + ' requirements), ' + 
				counter.failures + ' failures, ' + 
				counter.errors + ' errors'
			);
			System.exit(0);
		}
	}
}
