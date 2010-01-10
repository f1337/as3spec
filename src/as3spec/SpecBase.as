package as3spec { 
  
  import flash.utils.getTimer;
  import flash.events.EventDispatcher;
  
  public class SpecBase extends EventDispatcher {
    
    private var _startTime  : Number = -1;
    private var _stopTime   : Number = -1;
    
    public function startTimer() : void {
      if(_startTime>-1) return;
      _startTime = getTimer();
    }
    
    public function stopTimer() : void {
      if(_stopTime>-1) return;
      _stopTime = getTimer();
    }
    
    public function get time() : Number {
      return (_stopTime - _startTime);
    }

    

  }


}
