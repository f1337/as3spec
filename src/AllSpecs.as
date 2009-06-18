package
{
	import as3spec.*;

	public class AllSpecs extends Suite
	{
		public function AllSpecs ()
		{
			add(TestAS3Spec);
			add(TestUIComponentSpec);
		}
	}
}