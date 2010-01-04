package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.utils.getTimer;

	public class Context extends EventDispatcher
	{
	  static private var counter:Object = Suite.counter;
		private var specifications:Array; // LIFO stack: most recent spec at [0]
    public var printer:Printer;

		// >>> PUBLIC METHODS
		public function Context (context:*, printer:Printer)
		{
		  printer=printer;
			printer.puts('');
			printer.puts(context);
			specifications = [];
			counter.contexts[context]=specifications;
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
			var it:Specification = new Specification(printer);
			specifications.unshift(it);
			if(it.printer==null) it.printer=printer;
			it.apply(story, block);
		}
	}
}
