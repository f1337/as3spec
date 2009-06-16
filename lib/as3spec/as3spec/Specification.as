package as3spec
{
	import as3spec.*;
	import flash.events.*;

	public class Specification extends EventDispatcher
	{
		private var requirements:Array; // LIFO stack: most recent req at [0]

		public function Specification ()
		{
			requirements = [];
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
				status = 'ERROR';
//				trace('Error message: ' + error.message);
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
				trace('- ' + story + status);
			}
			
		}

		public function require (value:*) :Should
		{
			var should:Should = new Should(value);
			requirements.unshift(should);
			return should;
		}
	}
}
