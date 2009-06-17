package as3spec
{
	import as3spec.*;
	import flash.events.*;

	public class Specification extends EventDispatcher
	{
		static public var counter:Object = {
			specifications: 0,
			requirements:	0,
			failures:		0,
			errors:			0
		};

		private var requirements:Array; // LIFO stack: most recent req at [0]

		public function Specification ()
		{
			requirements = [];
			counter.specifications++;
		}

		public function apply (story:String, block:Function) :void
		{
			var status:String = '';

			try
			{
				block.apply();
			}
			catch (error:Error)
			{
				status = (error.message == 'FAILED' ? 'FAILED' : 'ERROR');
				trace('Stacktrace: ' + error.getStackTrace());
			}
			catch (exception:*)
			{
				status = 'FAILED';
			}
			finally
			{
				if (requirements.length < 1) status = 'MISSING';
				if (status != '') status = ' [' + status + ']';
				if (status == 'FAILED') counter.failures++;
				if (status == 'ERROR') counter.errors++;
				trace('- it ' + story + status);
			}
		}

		public function require (value:*) :Should
		{
			var should:Should = new Should(value);
			requirements.unshift(should);
			counter.requirements++;
			return should;
		}
	}
}
