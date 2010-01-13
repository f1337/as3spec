package
{
	import org.asspec.ui.SimpleRunner;
	
	public class <%= project_name %>Runner extends SimpleRunner
	{
		public function <%= project_name %>Runner ()
		{
			super(new AllTests);
		}
	}
}