package
{
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */

	import as3spec.*;
	import AS3Spec;

	public class SpecSuiteXML extends Suite
	{
		public function SpecSuiteXML ()
		{
			ci_output = true;
			trace_output = false;
			add(AS3Spec);
		}
	}
}