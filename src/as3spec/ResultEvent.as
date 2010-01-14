package as3spec
{
  
  import flash.events.Event;
  
  public class ResultEvent extends Event{
    
    public static const SUCCESS     : String  = "SUCCESS";
    public static const FAILED      : String  = "FAILED";
    public static const ERROR       : String  = "ERROR";
    public static const TIMEOUT     : String  = "TIMEOUT";
    public static const MISSING     : String  = "MISSING";
    
    public var success: Boolean;
    public var error: Error;
    public var story: String;
    public var time: Number;
    
    public function ResultEvent(type:String, story:String, time:Number, success:Boolean, error:Error=null, cancelable:Boolean=false, bubbles:Boolean=false){
      
      super(type, cancelable, bubbles);
      
			this.success=success;
			this.error=error;
			this.story=story;
			this.time=time;
			if(error!=null) error.name = type;
      
    }
    
    override public function clone() : Event {
      return new ResultEvent(type, story, time, success, error, cancelable, bubbles);
    }

    

  }


}