package as3spec
{
	import as3spec.*;
	import flash.system.*;
	import flash.utils.*;

	public class Suite
	{
		// summary counter
		static public var counter:Object = {
			specifications: 0,
			requirements:	0,
			failures:		0,
			errors:			0,
			missing:		0,
			time:       0,
			stacktraces:	[],
			contexts: []
		};

		// FIFO queue
		private var specs:Array = [];
		private var numSpecs:int=0;
		// delay exit(): allow running specs to complete
		public var asyncTime:Number = 2000;
		private var timer:Timer;
		public var printer:Printer;
		
		public function Suite():void
		{
		  timer = new Timer(asyncTime, 1);
		}
		
		public function run (...args) :void
		{
			if (specs.length < 1) return exit();
			var spec:* = new (specs.pop())();
			spec.printer=printer;
			spec.addEventListener('complete', run);
			spec.addEventListener('specComplete', specCompleted);
			spec._run();
		}

		protected function add (spec:Class) :void
		{
			specs.unshift(spec);
		}
		
		private function specCompleted(e:Object = null) :void {
		  //trace('specCompleted');
		}
		
		private function calculateTime() : void {
		  for(var countName:String in counter.contexts) {
        for each(var specification:Specification in counter.contexts[countName]) {
          counter.time+=specification.time;
        }
      }
		}

		private function summarize () :void
		{
			// 50 specifications (380 requirements), 1 failures, 1 errors
			calculateTime();
			trace('');
			trace(counter.stacktraces.join("\n\n"));
			trace('');
			var summary:String = (
				counter.specifications + ' specifications (' + 
				counter.requirements + ' requirements), ' + 
				counter.failures + ' failures, ' + 
				counter.errors + ' errors, ' +
				counter.missing + ' pending, ' +
				'time: ' + counter.time/1000 + ' seconds' 
			);
			printer.puts(summary);
			printer.xputs(counter);
		}

		private function exit (e:Object = null) :void
		{
			// delay exit() to allow running specs time to complete
			if (e == null)
			{
			  if(timer.running) {
				  timer.reset();
				} else {
				  timer.addEventListener('timerComplete', exit);
				}
				timer.start();
			}
			// done waiting, summarize and exit
			else
			{
				timer.removeEventListener('timerComplete', exit);
				timer.reset();
				summarize();
				System.exit(0);
			}
			return;
		}
	}
}