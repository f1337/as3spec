package as3spec
{
	import as3spec.*;
	import flash.events.*;

	public class Context extends EventDispatcher
	{
		private var specifications:Array; // LIFO stack: most recent spec at [0]


		// >>> PUBLIC METHODS
		public function Context (context:*)
		{
			trace('');
			trace(context);
			specifications = [];
		}

		public function describe (block:Function) :void
		{
			block.apply();
		}

		public function require (value:*) :Should
		{
			return specifications[0].require(value);
		}

		public function specify (story:String, block:Function) :void
		{
			var it:Specification = new Specification();
			specifications.unshift(it);
			it.apply(story, block);
		}
	}
}
