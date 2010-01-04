package as3spec
{
	import as3spec.*;
	import flash.events.*;

	public class Printer
	{
	  
	  public var printXML:Boolean = false;
	  public var printTrace:Boolean = true;
		
		public function puts(s : String) : void {
		  if(printTrace) trace('[as3spec] ' + s);
		}
		
		public function xputs(counter:Object) : void {
		  if(!printXML) return;
		  
		  //else
		  
		  trace('<XMLResultPrinter>');
      trace('<?xml version="1.0" encoding="UTF-8"?>');
      //trace('<testsuites>');
      trace('<testsuite name="AllSpecs" errors="' + counter.errors + '" failures="' + counter.failures + '" tests="' + counter.specifications + '" time="' + (counter.time/1000) + '">');
      for(var countName:String in counter.contexts) {
        for each(var specification:Specification in counter.contexts[countName]) {
          trace('<testcase classname="'+countName+"."+clean(specification.story)+'" name="'+clean(specification.story)+'" time="'+(specification.time/1000)+'">');
          if(specification.failure!=null) {
            trace('<failure type="'+clean(specification.failureType)+'"><![CDATA['+clean(specification.failure)+']]></failure>');
          }
          trace('</testcase>');
        }
      }
      trace('</testsuite>');
      //trace('</testsuites>');
      trace('</XMLResultPrinter>');
        
		}
		
		private function clean(str:String) : String {
		  var pat:RegExp = /"/g;
		  return str.replace(pat, "'");
		}
		
	}
}
