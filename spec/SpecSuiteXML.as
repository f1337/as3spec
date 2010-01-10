package
{
	import as3spec.*;

	public class SpecSuiteXML extends Suite
	{
		public function SpecSuiteXML ()
		{
		  ci_output=true;
		  trace_output=false;
			add(AS3Specs);
		}
	}
}