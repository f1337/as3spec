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
			return eval((this.value == null), 'be nil');
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
			return eval((this.value == value), 'equal', value);
		}

    // be more than
    // should be.more_than(value:*)
    public function more_than(value:*) :Boolean
    {
      return eval((this.value > value), 'more than', value);
    }
    
    // be less than
    // should be.less_than(value:*)
    public function less_than(value:*) :Boolean
    {
      return eval((this.value < value), 'less than', value);
    }


		// is Type
		// should.be.a.kind_of(Object)
		public function kind_of (klass:*) :Boolean
		{
			return eval((this.value is klass), 'be a kind of', klass);
		}

		// should.have('property')
		public function have (property:String) :Boolean
		{
			return eval((this.value.hasOwnProperty(property)), 'have property:', property);
		}

		// =~
		// should.match(/pattern/)
		public function match (pattern:*) :Boolean
		{
			return eval((this.value.match(pattern) != null), 'match', pattern);
		}

		// should.throw(error) would be nice,
		// but throw is a reserved word:
		// should.raise(error)
		public function raise (error:* = null) :Boolean
		{
			var raised:Boolean = false;

			try
			{
				this.value();
			}
			catch (exception:*)
			{
				if (error == null)
				{
					raised = true;
				}
				else if ((error is String) && (exception is Error))
				{
					raised = (exception.message == error);
				}
				else if (error is Class)
				{
					raised = (exception is error);
				}
				else
				{
					raised = (exception == error);
				}
			}
			return eval(raised, 'raise', error);
		}

		// ===
		// should.be.same(ref)
		public function same (value:*) :Boolean
		{
			return eval((this.value === value), 'be the same object as', value);
		}

		// should.trigger('event')
		public function trigger (event:String) :Boolean
		{
			return eval((this.value.hasEventListener(event)), 'trigger', event);
		}



		// >>> PRIVATE METHODS
		private function eval (result:Boolean, behavior:String, expected:* = '') :Boolean
		{
			var success:Boolean = (positive ? result : (! result));
			if (! success)
			{
				
				var error:Error = new Error();
				error.message = value + ' should ';
				error.message += (positive ? '' : 'not ');
				error.message += behavior + ' ' + expected;
				error.name = 'FAILED';
				throw(error);
			}
			return (positive ? result : (! result));
		}
	}
}
