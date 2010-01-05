package
{
	import as3spec.*;
	import mx.controls.*;
	import mx.core.*;

	public class UIComponentSpecs extends UIComponentSpec
	{
		override public function run () :void
		{
			const instance:UIComponent = new Button;

			describe (instance, 'is a component from the mx controls package', function () :void
			{
				it ('should be a UIComponent', function () :void
				{
					so(instance).should.be.a.kind_of(UIComponent);
				});
				
				it ('should have "initialized" before this specification was run', function () :void
				{
					so(instance.initialized).should.equal(true);
				});
			});

			describe (instance, 'described()', 'with', 'arbitrary', 'arguments', function () :void
			{
				it ('should succeed', function () :void
				{
					so(true).should.equal(true);
				});
			});
		}
	}
}