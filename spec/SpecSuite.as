package
{
	import as3spec.*;

	public class SpecSuite extends Suite
	{
		public function SpecSuite ()
		{
		  printer = new Printer;
			add(AS3Specs);
			add(UIComponentSpecs);
		}
	}
}