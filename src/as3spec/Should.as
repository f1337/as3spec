package as3spec
{
	import as3spec.*;
	import flash.events.*;
  import flash.utils.*;

	public class Should extends SpecBase
	{
		// >>> PRIVATE PROPERTIES
		private var positive:Boolean = true;
		private var eventObject:* = null;
		private var async:Boolean = false;
		private var noValue:Boolean = false;
		private var expectedValues:Array;
		private var event:String;
		private var matcher:Function;
		private var timer:Timer;
		private var didTimeout:Boolean = false;
		
		// >>> PRIVATE GETTER/SETTER PROPERTIES
		private var _value:*;
		private var _object:* = null;
		private var _property:* = null;
		private var _story:String;
		private var _timeout:Number = 10000;
		private var _specify:Function;
		private var _params:Array;


		// should.be
		// should.be.a
		// should.be.an
		public function get a  () :Should { return be; }
		public function get an () :Should { return be; }
		//public function get as () :Should { return be; }
		public function get to () :Should { return be; }
		public function get be () :Should
		{
			return this;
		}
		
		// so(object, 'value').when.receiving('eventName').should.equal(5)
		public function receiving(event:String) : Should {
		  this.event = event;
		  if(object == null && value is Object) object = value;
		  if(object is EventDispatcher) object.addEventListener(this.event, eventReceived);
		  timer=new Timer(timeout, 1);
		  timer.addEventListener(TimerEvent.TIMER, timeoutReached);
		  return this;
		}
		
		public function from(eventObject:*) : Should {
		  this.eventObject = eventObject;
		  if(object is EventDispatcher) object.removeEventListener(this.event, eventReceived);
		  if(this.eventObject is EventDispatcher) this.eventObject.addEventListener(this.event, eventReceived);
		  return this;
		}
		
		private function eventReceived(e:*=null) : void {
		  timer.stop();
		  timer.removeEventListener(TimerEvent.TIMER, timeoutReached);
		  
		  if(this.eventObject is EventDispatcher) {
		    this.eventObject.removeEventListener(this.event, eventReceived);
		  } else if(object is EventDispatcher){
		    object.removeEventListener(this.event, eventReceived); 
		  }
		  
		  async=false;
		  run();
		}
		
		private function timeoutReached(e:*=null) : void {
		  didTimeout=true;
		  eventReceived();
		}
		
		public function get when() :Should {
		  async=true;
		  return this;
		}
		
		public function get second() : Should { 
		  return seconds;
		}
		
		public function get seconds() : Should { 
		  return this; 
		}
		
		public function after(secs:Number) : Should {
		  async=true;
		  timeout=secs*1000;
		  timer=new Timer(timeout, 1);
		  timer.addEventListener(TimerEvent.TIMER, aftertimeoutReached);
		  return this;
		}
		
		private function aftertimeoutReached(e:*=null) : void {
		  timer.stop();
		  timer.removeEventListener(TimerEvent.TIMER, timeoutReached);
		  async=false;
		  run();
		}
		
		private function reset() : void {
		  if(timer!=null) {
		    timer.stop();
		    timer.removeEventListener(TimerEvent.TIMER, timeoutReached);
		    timer.removeEventListener(TimerEvent.TIMER, aftertimeoutReached);
		  }
		  if(object!=null && this.event!=null) object.removeEventListener(this.event, eventReceived);
		  if(this.eventObject!=null && this.event!=null) this.eventObject.removeEventListener(this.event, eventReceived);
		}

		public function set params(value:Array):void
		{
		  _params = value;
		}
		
		public function get params():Array
		{
		  return _params;
		}

    public function get specify() : Function { 
      return _specify; 
    }
    
    public function set specify(value:Function) : void { 
      _specify = value; 
    }

    public function set timeout(value:Number) : void { 
      _timeout = value; 
    }
    
    public function get timeout() : Number { 
      return _timeout; 
    }

    // == null
		// should.be.nil
		
		private function getNil() : Should {
		  return eval((this.value == null), 'be nil');
		}
		
		public function get nil () :Should
		{
		  matcher=getNil;
		  noValue=true;
		  return this;
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

    public function set story(value:String) :void {
      _story = value;
    }
    
    public function get story() : String {
      return _story;
    }

    public function set value(value:*) :void {
      _value=value;
    }
    
    public function get value() :* {
      if(object!=null && property!=null) return object[property];
      return _value;
    }
    
    public function set property(property:*) : void { 
      _property = property; 
    }
    
    public function get property() : * { 
      return _property; 
    }
    
    public function set object(value:*) : void {
      _object = value; 
    }
    
    public function get object() : * { 
      return _object; 
    }

		// == 123
		// should.equal(123)
		public function equal (value:*) :Should
		{
		  setMatcherAndExcpectedValues(_equal, value);
		  return this;
		}
		
		public function equal_to (value:*) :Should
		{
		  return equal(value);
		}

    private function _equal(value:*) : void {
      eval((this.value == value), 'equal', value);
    }
    
    public function give(value:*):Should
    {
      setMatcherAndExcpectedValues(_give, value);
      return this;
    }
    
    private function _give(value:*):void
    {
      var raised:Boolean = false;
      var rval:*;
      var error:*;
      
      try
			{
				rval = this.value();
			}
			catch (e:*)
			{
			  error = e;
			  raised = true;
			}
			
			if(raised) {
        exitAndReportError(error);
			} else {
			  eval((rval == expectedValues[0]), 'give', value);
			}
			
    }
    
    // be between
    // should be.between(value1:*, value2:*)
    public function between(value1:*, value2:*) : Should {
      setMatcherAndExcpectedValues(_between, value1, value2);
      return this;
    }
    
    private function _between(value1:*, value2:*) : void {
      if(value1<value2) {
        eval((this.value >= value1 && this.value <= value2), 'be between', value1 + ' and ' + value2);
      } else {
        eval((this.value <= value1 && this.value >= value2), 'be between', value1 + ' and ' + value2);
      }
    }
    
    
    // be more than
    // should be.more_than(value:*)
    public function more_than(value:*) :Should
    {
      setMatcherAndExcpectedValues(_more_than, value);
      return this;
    }
    
    private function _more_than(value:*) : void {
      eval((this.value > value), 'be more than', value);
    }
    
    // be less than
    // should be.less_than(value:*)
    public function less_than(value:*) :Should
    {
      setMatcherAndExcpectedValues(_less_than, value);
      return this;
    }
    
    private function _less_than(value:*) : void {
      eval((this.value < value), 'be less than', value);
    }


		// is Type
		// should.be.a.kind_of(Object)
		public function kind_of (klass:*) :Should
		{
		  setMatcherAndExcpectedValues(_kind_of, klass);
      return this;
		}

    private function _kind_of(klass:*) : void {
      eval((this.value is klass), 'be a kind of', klass);
    }

		// should.have('property')
		public function have (prop:String) :Should
		{
		  setMatcherAndExcpectedValues(_have, prop);
		  return this;
		}
		
		private function _have(prop:*) : void {
		  eval((this.value.hasOwnProperty(prop)), 'have property:', prop);
		}

		// =~
		// should.match(/pattern/)
		public function match (pattern:*) :Should
		{
		  setMatcherAndExcpectedValues(_match, pattern);
		  return this;
		}
		
		private function _match(pattern:*) : void {
		  eval((this.value.match(pattern) != null), 'match', pattern);
		}

		// should.throw(error) would be nice,
		// but throw is a reserved word:
		// should.raise(error)
		public function raise (error:* = null) :Should
		{
		  setMatcherAndExcpectedValues(_raise, error);
			return this;
		}
		
		private function _raise(error:* = null) : void {
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
			eval(raised, 'raise', error);
		}

		// ===
		// should.be.same(ref)
		public function same (value:*) :Should
		{
		  setMatcherAndExcpectedValues(_same, value);
		  return this;
		}
		
		public function same_as(value:*) :Should {
		  return same(value);
		}
		
		private function _same(value:*) : void {
		  eval((this.value === value), 'be the same object as', value)
		}

		// should.trigger('event')
		public function trigger (event:String) :Should
		{
		  setMatcherAndExcpectedValues(_trigger, event);
		  return this;
		}
		
		private function _trigger(event:String) : void {
		  eval((this.value.hasEventListener(event)), 'trigger', event);
		}

    public function run() :Should {
      startTimer();
      
      try
			{
			  (params!=null) ?
				  specify.apply(NaN, params) :
				  specify.apply();
			}
			catch (error:*)
			{
			  return exitAndReportError(error);
			}
			
      if(timer!=null) timer.start();
      
      
      (!noValue) ?
        matcher.apply(this, expectedValues) :
        matcher.apply(this);
        
      return this;
    }
    
    
		
		private function setMatcherAndExcpectedValues(... args) : void {
		  try {
		    this.matcher=args.shift();
		    this.expectedValues=args.slice(0);
		  } catch(error:*) {
		    exitAndReportError(error);
		  }
		}
		
		private function exitAndReportError(error:Error) : Should {
		  stopTimer();
		  reset();
		  dispatchEvent(new ResultEvent(ResultEvent.ERROR, story, time, false, error));
		  return this;
		}
		
		private function eval (result:Boolean, behavior:String, expected:* = '') :Should
		{
		  if(async) return this; //do not run immediately when asynchronous (i.e waiting for event or timeout)
		  
			var success:Boolean = (positive ? result : (! result));
			if (! success || didTimeout)
			{
				
				var error:Error = new Error();
				error.message = value + ' should ';
				error.message += (positive ? '' : 'not ');
				error.message += behavior + ' ' + expected;
				if(didTimeout) error.message += ' waited for '+timeout+' ms';
				
			}
			
			stopTimer();
			
			var resultEvent:ResultEvent;
			
			if(success && !didTimeout) {
			  resultEvent = new ResultEvent(ResultEvent.SUCCESS, story, time, success)
			} else if(didTimeout) {
			  resultEvent = new ResultEvent(ResultEvent.TIMEOUT, story, time, success, error);
			} else {
			  resultEvent = new ResultEvent(ResultEvent.FAILED, story, time, success, error);
			}
			
			dispatchEvent(resultEvent);

			return this;
		}
	}
}