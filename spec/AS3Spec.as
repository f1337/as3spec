package
{
	import as3spec.*;
	import flash.utils.*;
  import flash.events.*;


	public class AS3Spec extends Spec
	{
	  private var nothing:String;
	  private var arr:Array;
	  private var myTimer1:Timer;
	  private var myTimer2:Timer;
	  private var myTimer3:Timer;
	  private var myTimer4:Timer;
	  private var myObject:Object;
	  
	  override public function before():void
	  {
	   arr=new Array;
	   myTimer1=new Timer(1000, 1);
	   myTimer2=new Timer(1000, 1);
	   myTimer3=new Timer(1000, 1);
	   myTimer4=new Timer(1000, 1);
	   myObject={};
	  }
	  
	  
		
		override public function after():void
	  {
	    myTimer1.stop();
	    myTimer2.stop();
	    myTimer3.stop();
	  }
	  
		override public function run () :void
		{
		  
			describe ('as3spec', function () :void
			{
				
				it ('provides should.equal').so(23).should.equal(23);
				it ('provides should.not.equal').so(23).should.not.equal(12);
				it ('provides should.be.same').so(arr).should.be.same_as(arr);
        it ('provides should.not.be.same').so(arr).should.not.be.same_as((new Array));
        it ('provides should.be.nil').so(nothing).should.be.nil;
        it ('provides should.not.be.nil').so(arr).should.not.be.nil;
				it ('provides should.have').so(arr).should.have('length');
				it ('provides should.not.have').so(arr).should.not.have('kittens');
        it ('provides should.match').so('hello').should.match(/ell/);
        it ('provides should.not.match').so('hello').should.not.match(/egg/);
        it ('provides should.be.a.kind_of').so(arr).should.be.a.kind_of(Array);
        it ('provides should.not.be.a.kind_of').so(arr).should.not.be.a.kind_of(Boolean);
        
        it ('provides should.raise(message)')
          .so(function() :void
          {
            throw('an error');
          })
          .should.raise('an error');
          
				it ('provides should.not.raise(message)')
				  .so(function() :void
				  {
				    //nothing here
				  })
				  .should.not.raise('an error');

				it ('provides should.raise(class)')
					.so(function () :void
					{
						throw(new Error('an error'));
					})
					.should.raise(Error);
				
				it('provides should.not.raise(class)')
				  .so(function () :void
					{
						// do nothing
					})
					.should.not.raise(Error);
        
        it ('provides should.raise()')
          .so(function () :void
					{
						throw(new Error('an error'));
					}).should.raise();
					
				it ('provides should.not.raise()')
				  .so(function () :void
  				{
  					// do nothing
  				}).should.not.raise();
        
				
				it ('provides should.not.trigger')
				  .so(myTimer1).should.not.trigger('timer');
				  
				it ('provides should.trigger', function() :void
				{
				  myTimer1.addEventListener('timer', function(t:*) : void {});
				})
				  .so(myTimer1).should.trigger('timer');
				
				
				it ('provides after(time).second', function() :void {
			      setTimeout(function(t:*=null) :void{ myObject.myVal=5234 }, 900);
			    })
				  .so(myObject, 'myVal')
				  .after(1).second
				  .should.equal(5234);
				
				it ('provides after(time).seconds', function() :void {
			      setTimeout(function(t:*=null) :void{ myObject.myVal=2255 }, 300);
			    })
				  .so(myObject, 'myVal')
				  .after(0.5).seconds
				  .should.equal(2255);
			  
			  it('provides when.receiving(event)', function() :void
		    {
		      myTimer2.start();
		    })    
		      .so(myTimer2)
            .when.receiving(TimerEvent.TIMER)
            .should.be.same_as(myTimer2);
            
			  
				it('provides when.receiving(event).from(object)', function() :void
		    {
		      myTimer3.start();
		    })    
		      .so(123)
            .when.receiving(TimerEvent.TIMER).from(myTimer3)
            .should.be.equal_to(123);
        
        
        var arbitraryArg:String = 'dont be this';
        
        it('takes arbitrary arguments to specify block and can take a method to evaluate(run) in require', function(arbArg:String) :void
		    {
		      arbitraryArg=arbArg;
		    },
		    'please be this')    
		      .so(function() : Boolean {
		        return (arbitraryArg == 'please be this');
		      })
            .should.give(true);
            
        it('should generate an error if block passed to require throws')    
		      .so(function() : Boolean {
		        var someObject:*;
		        return someObject.nonExistant();
		      })
            .should.give(true);

				it ('catches an error', function () :void
				{
					throw(new Error('catch me if you can!'));
				}).so(arr);

				it ('catches a failure')
				  .so(23).should.equal(15);
				  
				timeout = 500;
				it ('can time out', function() :void
				{
				  myTimer4.start();
				})
				  .so(123)
				    .when.receiving(TimerEvent.TIMER).from(myTimer4)
				    .should.be.equal_to(123);

			});

			
		}
		
	}
}