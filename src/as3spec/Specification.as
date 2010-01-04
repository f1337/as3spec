package as3spec
{
	import as3spec.*;
	import flash.events.*;
	import flash.utils.getTimer;

	public class Specification extends EventDispatcher
	{
		static private var counter:Object = Suite.counter;
		private var requirements:Array; // LIFO stack: most recent req at [0]
    public var printer:Printer;
    public var story:String;
    public var time:Number;
    
		public function Specification (printer:Printer)
		{
		  printer=printer;
			requirements = [];
			counter.specifications++;
		}

		public function apply (story:String, block:Function) :void
		{
		  var ts:Number=getTimer();
		  this.story=story;
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
				printer.puts('- ' + story + status);
			}
			time=getTimer()-ts;
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
