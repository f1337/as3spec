package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.system.*;

	public class Spec extends EventDispatcher
	{
		// LIFO stack: most recent context at [0]
		static private var contexts:Array = [];

		public var describe:Function = context;
		public var printer:Printer;

		public function context (...args) :void
		{
			if (args.length < 2) throw('invalid arguments for describe()');

			var block:Function = (args.pop() as Function);
			if (block == null) throw('describe() expects function() block');

			var context:String = args.join(' ');
      
			contexts.unshift(new Context(context, printer));
			contexts[0].describe(block);
			contexts.shift();

			// tell Suite this Spec is done, move on to the next!
			if (contexts.length == 0) {
			  dispatchEvent(new Event('complete'));
		  } else {
		    dispatchEvent(new Event('specComplete'));
		  }
		}

		public var it:Function = specify;
		public function specify (story:String, block:Function) :void
		{
		  if(contexts[0].printer==null) contexts[0].printer=printer;
			contexts[0].specify(story, block);
		}

		public var expect:Function = require;
		public var so:Function = require;
		public var therefore:Function = require;
		public function require (value:*) :Should
		{
			return contexts[0].require(value);
		}
	}
}
