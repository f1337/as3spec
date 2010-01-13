package
{
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */

	import as3spec.*;<% test_case_classes.each do |test_case| %>
	import <%= test_case %>;<% end %>

	public class SpecSuiteXML extends Suite
	{
		public function SpecSuiteXML ()
		{
			ci_output = true;
			trace_output = false;<% test_case_classes.each do |test_case| %>
			add(<%= test_case %>);<% end %>
		}
	}
}