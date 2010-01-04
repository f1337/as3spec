package
{
	import as3spec.*;

	public class SpecSuiteXML extends Suite
	{
		public function SpecSuiteXML ()
		{
		  printer = new Printer;
		  printer.printXML = true;
		  printer.printTrace = false;
			add(AS3Specs);
			add(UIComponentSpecs);
		}
	}
}