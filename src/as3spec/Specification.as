package as3spec
{
	import as3spec.*;
	import flash.events.*;

	public class Specification extends EventDispatcher
	{
		static private var counter:Object = Suite.counter;
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
				status = (error.name == 'FAILED' ? 'FAILED' : 'ERROR');
				counter.stacktraces.push(error.getStackTrace());
			}
			catch (exception:*)
			{
				status = 'FAILED';
			}
			finally
			{
				if (requirements.length < 1)
				{
					status = 'MISSING';
					counter.missing++;
				}
				if (status == 'FAILED') counter.failures++;
				if (status == 'ERROR') counter.errors++;
				if (status != '') status = ' [' + status + ']';
				Spec.puts('- it ' + story + status);
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
