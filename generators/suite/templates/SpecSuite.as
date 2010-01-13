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

	public class SpecSuite extends Suite
	{
		public function SpecSuite ()
		{<% test_case_classes.each do |test_case| %>
			add(<%= test_case %>);<% end %>
		}
	}
}