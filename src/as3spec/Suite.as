package as3spec
{ 
  
  import flash.system.*;
  
  public class Suite extends SpecBase{
    
    private var specs:Array;
    private var finishedSpecs:Array;
    
    public function Suite(){
      specs=[];
      finishedSpecs=[];
      ci_output = false;
    }
    
    public function set ci_output(value:Boolean) : void { 
      Printer.printer.printXML = value;
    }
    
    public function get ci_output() : Boolean { 
      return Printer.printer.printXML; 
    }
    
    public function set trace_output(value:Boolean) : void { 
      Printer.printer.printTrace = value; 
    }
    
    public function get trace_output() : Boolean { 
      return Printer.printer.printTrace; 
    }
    
    public function run() : void {
      startTimer();
      if(specs.length==0) return runComplete();
      var klass:Class = specs.shift() as Class;
      var spec:Spec = new klass() as Spec;
      spec.addEventListener(Spec.COMPLETE, nextRun);
      spec.begin();
    }
    
    private function nextRun(e:*=null) : void {
      var spec:Spec = e.target as Spec;
      spec.removeEventListener(Spec.COMPLETE, nextRun);
      finishedSpecs.push(spec);
      run();
    }
    
    private function runComplete() : void {
      stopTimer();
      Printer.printer.summary(finishedSpecs, time);
      System.exit(0);
    }
    
    public function add(spec:Class) : void {
      specs.push(spec);
    }

    

  }


}
