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
			stacktraces:	[]
		};

		// FIFO queue
		private var specs:Array = [];
		// delay exit(): allow running specs to complete
		private var timer:Timer = new Timer(1500, 1);

		public function run (...args) :void
		{
			if (specs.length < 1) return exit();

			var spec:* = new (specs.pop())();
			spec.addEventListener('complete', run);
			spec.run();
		}

		protected function add (spec:Class) :void
		{
			specs.unshift(spec);
		}

		private function summarize () :void
		{
			// 50 specifications (380 requirements), 1 failures, 1 errors
			trace('');
			trace(counter.stacktraces.join("\n\n"));
			trace('');
			var summary:String = (
				counter.specifications + ' specifications (' + 
				counter.requirements + ' requirements), ' + 
				counter.failures + ' failures, ' + 
				counter.errors + ' errors, ' +
				counter.missing + ' pending'
			);
			Spec.puts(summary);
		}

		private function exit (e:Object = null) :void
		{
			// delay exit() to allow running specs time to complete
			if (e == null)
			{
				timer.addEventListener('timerComplete', exit);
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