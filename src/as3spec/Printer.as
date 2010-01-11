package as3spec
{
	import as3spec.*;
	import flash.events.*;

	public class Printer
	{
	  
	  private static var _PRINTER : Printer = null;
	  
	  public static function get printer() : Printer {
	    if(_PRINTER==null) _PRINTER = new Printer;
	    return _PRINTER;
	  }
	  
	  public var printXML:Boolean = false;
	  public var printTrace:Boolean = true;
	  
	  private var suiteXML: XML = <testsuite></testsuite>;
	  private var testCase: XML;
	  
	  private var desc : String;
	  
		public function description(s : String) : void {
		  desc = s;
		  puts('');
		  puts(s);
		}
		
		public function specification(s : String, type : String, time : Number, error:Error = null) : void {
		  var out:String = '- '+s;
		  out = (type==null) ? out : out+' ['+type+']';
		  puts (out);
		  
		  if(error!=null) puts('- >>> info: '+error.message+' ['+type+'] <<<');
		  
		  specificationXML(s, type, time, error);
		}
		
		private function specificationXML(s : String, type : String, time : Number, error:Error = null) : void {
		  if(!printXML) return;
		  
		  testCase = <testcase></testcase>;
		  testCase.@classname = clean(desc);
		  testCase.@name = clean(s);
		  testCase.@time = time/1000;
		  
		  suiteXML.appendChild(testCase);
      
		  if(error!=null) {
		    
		    var failureXml:XML = <failure></failure>;
		    failureXml.@type=clean(type);
		    
		    if(type == ResultEvent.ERROR) failureXml.appendChild('<![CDATA['+error.message+"\n"+error.getStackTrace()+']]>');
		    
		    testCase.appendChild(failureXml);
		    
	    }
		}
		
		public function summary(specArray:Array, time:Number) : void {
		  
		  var specifications:int=0;
		  var failures:int=0;
		  var successes:int=0;
		  var errors:int=0;
		  var timeouts:int=0;
		  
		  for each (var spec:Spec in specArray) {
		    specifications+=spec.specifications;
		    failures+=spec.failures;
		    successes+=spec.successes;
		    errors+=spec.errors;
		    timeouts+=spec.timeouts;
		  }
		  
		  puts('');
		  
		  puts(
		    specifications + ' specifications, ' + 
				failures + ' failures, ' + 
				errors + ' errors, ' +
				timeouts + ' timeouts, ' +
				'time: ' + time/1000 + ' seconds'
		  );
		  
		  summaryXML(specifications, failures, errors, successes, timeouts, time);
		  
		  putsXML();
		  
		}
		
		private function summaryXML(specifications : int, failures : int, errors : int, successes : int, timeouts : int, time : Number) : void {
		  if(!printXML) return;
		  
		  suiteXML.@time=time/1000;
		  suiteXML.@failures=failures;
		  suiteXML.@errors=errors;
		  suiteXML.@timeouts=timeouts;
		  suiteXML.@tests=specifications;
		  
		}
		
		private function putsXML() : void {
		  if(printXML) {
		    //fix this later
		    suiteXML.@name = 'AllSpecs';
		    trace('<XMLResultPrinter>');
		    trace('<?xml version="1.0" encoding="UTF-8"?>');
		    XML.prettyIndent = 0;
		    trace(suiteXML.toXMLString());
		    trace('</XMLResultPrinter>');
		  }
		}
		
		public function puts(s : String) : void {
		  if(printTrace) trace('[as3spec] ' + s);
		}
		
		
		// cleans strings that are put in xml attributes
		private function clean(str:String) : String {
		  var pat:RegExp = /"/g;
		  return str.replace(pat, "'");
		}
		
	}
}
