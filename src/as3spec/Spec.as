package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.system.*;
	import flash.utils.Timer;

	public class Spec extends EventDispatcher
	{
		// LIFO stack: most recent context at [0]
		static private var contexts:Array = [];

		public var describe:Function = context;
		public var printer:Printer;
		public var asyncTime:Number=0;
    private var asyncTimer:Timer;
    
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
		
		/// override if needed
		
		public function before() : void{}
		public function after() : void{}
		public function run() : void{}
		public function runLater() : void{}
		
		///
		
		public function _run() : void {
		  before();
		  run();
		  if(asyncTime>0) {
		    asyncTimer = new Timer(asyncTime, 1);
		    asyncTimer.addEventListener('timerComplete', _runLater);
		    asyncTimer.start();
		  } else {
		    runLater();
		    after();
		  }
		}
		
		private function _runLater(e:*=null) : void {
		  runLater();
		  after();
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
