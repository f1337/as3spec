package
{
	import as3spec.*;
	import flash.utils.*;

	public class TestAS3Spec extends Spec
	{
		public function run () :void
		{
			describe ('as3spec', function () :void
			{
				const arr:Array = new Array;

				it ('provides should.equal and should.not.equal', function () :void
				{
					// ==
					so(23).should.equal(23);
					// !=
					so(23).should.not.equal(15);
				});

				it ('provides should.be.same and should.not.be.same', function () :void
				{
					// ===
					so(arr).should.be.same(arr);
					// !==
					so(arr).should.not.be.same((new Array));
				});

				it ('provides should.be.nil and should.not.be.nil', function () :void
				{
					// == null
					var nothing:String;
					so(nothing).should.be.nil;
					// != null
					so(arr).should.not.be.nil;
				});

				it ('provides should.have and should.not.have', function () :void
				{
					so(arr).should.have('length');
					so(arr).should.not.have('kittens');
				});

				it ('provides should.match and should.not.match', function () :void
				{
					// =~
					so('hello').should.match(/ell/);
					// !=~
					so('hello').should.not.match(/egg/);
				});

				it ('provides should.be.a.kind_of and should.not.be.a.kind_of', function () :void
				{
					// "var is Type"
					so(arr).should.be.a.kind_of(Array);
					so(arr).should.not.be.a.kind_of(Boolean);
				});

				it ('provides should.raise(message) and should.not.raise(message)', function () :void
				{
					// throws
					so(function () :void
					{
						throw('an error');
					}).should.raise('an error');
					so(function () :void
					{
						// do nothing
					}).should.not.raise('an error');
				});

				it ('provides should.raise(class) and should.not.raise(class)', function () :void
				{
					// throws
					so(function () :void
					{
						throw(new Error('an error'));
					}).should.raise(Error);
					so(function () :void
					{
						// do nothing
					}).should.not.raise(Error);
				});

				it ('provides should.raise() and should.not.raise()', function () :void
				{
					// throws
					so(function () :void
					{
						throw(new Error('an error'));
					}).should.raise();
					so(function () :void
					{
						// do nothing
					}).should.not.raise();
				});

				it ('provides should.trigger and should.not.trigger', function () :void
				{
					var t:Timer = new Timer(1000);
					so(t).should.not.trigger('timer');
					t.addEventListener('timer', function () :void {});
					so(t).should.trigger('timer');
				});

				it ('catches an empty specification', function () :void
				{
				});

				it ('catches an error', function () :void
				{
					so(arr);
					throw(new Error('catch me if you can!'));
				});

				it ('catches a failure', function () :void
				{
					so(23).should.equal(15);
				});


				describe ('with a nested describe() block', function () :void
				{
					it ('should succeed', function () :void
					{
						so(true).should.equal(true);
					});
				});
			});

			describe ('describe()', 'with', 'arbitrary', 'arguments', function () :void
			{
				it ('should succeed', function () :void
				{
					so(true).should.equal(true);
				});
			});

			context ('context()', function () :void
			{
				specify ('should support specify() and require()', function () :void
				{
					require(true).should.equal(true);
				});

				specify ('should support expect()', function () :void
				{
					expect(true).should.equal(true);
				});

				specify ('should support therefore()', function () :void
				{
					therefore(true).should.equal(true);
				});
			});
		}
	}
}