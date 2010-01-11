package as3spec
{
  import flash.system.*;
  import flash.events.*;
  
  public class Spec extends SpecBase{
    
    public static const COMPLETE : String = 'specComplete';
    
    // >>> PRIVATE PROPERTIES
    private var contexts        : Array;
    private var currentContext  : Object;
    private var should          : Should;
    
    // >>> PRIVATE GETTER/SETTER PROPERTIES
    private var _specifications         : int = 0;
    private var _successes              : int = 0;
    private var _failures               : int = 0;
    private var _errors                 : int = 0;
    private var _timeouts               : int = 0;
    
    private var _timeout                : Number = -1;
    
    
    public function get successes() : int { 
      return _successes; 
    }
    
    public function get failures() : int { 
      return _failures; 
    }
    
    public function get specifications() : int { 
      return _specifications; 
    }
    
    public function get errors() : int { 
      return _errors; 
    }
    
    public function get timeouts() : int { 
      return _timeouts; 
    }
    
    public function set timeout(value:Number) : void { 
      _timeout = value; 
    }
    
    public function get timeout() : Number { 
      return _timeout; 
    }
    
    //---- override these
    public function before() : void{}
		public function after() : void{}
		public function run() : void{}
		//----
		
		public var describe:Function = context;
		public function context (description:String, block:Function) :void
		{
		  currentContext = { description: description, specs: [] };
		  if(contexts == null) contexts = [];
		  contexts.push(currentContext);
		  block.apply();
		}
		
		
		public var it:Function = specify;
		public function specify (story:String, block:Function=null) :Spec {
		  _specifications++;
		  
		  should=new Should();
		  should.story=story;
		  
		  should.specify = (block==null) ? 
		    function() : void{} :
		    block;
		  
		  if(timeout>-1) should.timeout = timeout;
		  
		  return this;
		}
		
		public var expect:Function = require;
		public var so:Function = require;
		public var therefore:Function = require;
		public function require (... args) :Should
		{
		  if(args.length>1) {
		    
		    should.object=args[0];
		    should.property=args[1];
		  
		  } else {
		    
		    should.value=args[0];
		  
		  }
		  currentContext.specs.push(should);
	    return should;
		}
		
		private function next() : void {
		  
		  if(contexts.length<=0 && currentContext.specs.length<=0) return cleanup();
		  
		  if(currentContext==null || currentContext.specs.length==0) {
		    currentContext=contexts.shift();
		    Printer.printer.description(currentContext.description);
	    }
	    
	    if(currentContext.specs.length==0) {
	      Printer.printer.puts(' - empty context [EMPTY]');
	      return next();
		  }
		  
		  should = currentContext.specs.shift() as Should;
		  
		  should.addEventListener(ResultEvent.SUCCESS, testSuccess);
		  should.addEventListener(ResultEvent.FAILED, testFailure);
		  should.addEventListener(ResultEvent.ERROR, testError);
		  should.addEventListener(ResultEvent.TIMEOUT, testTimeout);
		  should.run();
		}
		
		private function testError(re:ResultEvent) : void {
		  _errors++;
		  removeListeners();
		  Printer.printer.specification(re.story, re.type, re.time, re.error);
		  next();
		}
		
		private function testSuccess(re:ResultEvent) : void {
		  _successes++;
		  removeListeners();
		  Printer.printer.specification(re.story, re.type, re.time);
		  next();
		}

    private function testFailure(re:ResultEvent) : void {
      _failures++;
      removeListeners();
      Printer.printer.specification(re.story, re.type, re.time, re.error);
      next();
    }
    
    private function testTimeout(re:ResultEvent) : void {
      _timeouts++;
      removeListeners();
      Printer.printer.specification(re.story, re.type, re.time, re.error);
      next();
    }

    private function removeListeners() : void {
      if(should==null) return;
      should.removeEventListener(ResultEvent.SUCCESS, testSuccess);
      should.removeEventListener(ResultEvent.FAILED, testFailure);
      should.removeEventListener(ResultEvent.ERROR, testError);
      should.removeEventListener(ResultEvent.TIMEOUT, testTimeout);
    }
    
    protected function cleanup() : void {
      after();
      stopTimer();
      dispatchEvent(new Event(Spec.COMPLETE));
    }
    public function begin() : void {
      contexts=[];
      startTimer();
      before();
      run();
      currentContext=null;
      next();
    }

  }


}
