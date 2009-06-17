package
{
	import as3spec.*;

	public class TestAS3Spec extends Spec
	{
		public function TestAS3Spec ()
		{
			describe ('as3spec', function () :void
			{
				const arr:Array = new Array;

				it ('should provide a basic suite of requirements', function () :void
				{
					// ==
					so(23).should.equal(23);
					// !=
					so(23).should.not.equal(15);

					// ===
					so(arr).should.be.same(arr);
					// !==
					so(arr).should.not.be.same((new Array));

					// == null
					var nothing:String;
					so(nothing).should.be.nil;
					// != null
					so(arr).should.not.be.nil;

					// =~
					so('hello').should.match(/ell/);
					// !=~
					so('hello').should.not.match(/egg/);

					// "var is Type"
					so(arr).should.be.a.kind_of(Array);
					so(arr).should.not.be.a.kind_of(Boolean);
				});

				it ('should trap an empty specification', function () :void
				{
				});

				it ('should trap an error', function () :void
				{
					so(arr);
					throw(new Error('catch me if you can!'));
				});

				it ('should trap a failure', function () :void
				{
					so(23).should.equal(15);
				});
			});

			describe ('describe()', 'with', 'arbitrary', 'arguments', function () :void
			{
				it ('should succeed', function () :void
				{
					so(true).should.equal(true);
				});
			});
		}
	}
}

/*
assert_equal:			should.equal, should ==
assert_not_equal:		should.not.equal, should.not ==
assert_same:			should.be
assert_not_same:		should.not.be
assert_nil:				should.be.nil
assert_not_nil:			should.not.be.nil

*assert_in_delta:		should.be.close

assert_match:			should.match, should =~
assert_no_match:		should.not.match, should.not =~

* assert_instance_of:		should.be.an.instance_of

assert_kind_of:			should.be.a.kind_of

assert_respond_to:		should.respond_to
assert_raise:			should.raise
assert_nothing_raised:	should.not.raise
assert_throws:			should.throw
assert_nothing_thrown:	should.not.throw
assert_block:			should.satisfy
*/