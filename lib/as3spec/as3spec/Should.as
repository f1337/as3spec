package as3spec
{
	import as3spec.*;
	import flash.events.*;

	public class Should extends EventDispatcher
	{
		// >>> PRIVATE PROPERTIES
		private var positive:Boolean = true;
		private var value:*;

		public function Should (value:*)
		{
			this.value = value;
		}

		// should.be
		// should.be.a
		// should.be.an
		public function get a  () :Should { return be; }
		public function get an () :Should { return be; }
		public function get be () :Should
		{
			return this;
		}

		// == null
		// should.be.nil
		public function get nil () :Boolean
		{
			return eval(this.value == null);
		}

		// !
		// should.not.be
		public function get not () :Should
		{
			positive = false;
			return be;
		}

		// should
		public function get should () :Should
		{
			return this;
		}


		// >>> PUBLIC METHODS
		// == 123
		// should.equal(123)
		public function equal (value:*) :Boolean
		{
			return eval(this.value == value);
		}

		// is Type
		// should.be.a.kind_of(Object)
		public function kind_of (klass:*) :Boolean
		{
			return eval(this.value is klass);
		}

		// =~
		// should.match(/pattern/)
		public function match (pattern:*) :Boolean
		{
			return eval(this.value.match(pattern) != null);
		}

		// ===
		// should.be.same(ref)
		public function same (value:*) :Boolean
		{
			return eval(this.value === value);
		}

		// should.throw(error)
		public function raise (error:*) :Boolean
		{
			try
			{
				this.value();
			}
			catch (exception:*)
			{
				if ((error is String) && (exception is Error))
				{
					return eval(exception.message == error);
				}
				else if (error is Class)
				{
					return eval(exception is error);
				}
				else
				{
					return eval(exception == error);
				}
			}
			return eval(false);
		}



		// >>> PRIVATE METHODS
		private function eval (result:Boolean) :Boolean
		{
			var success:Boolean = (positive ? result : (! result));
			if (! success) throw(new Error('FAILED'));
			return (positive ? result : (! result));
		}
	}
}
