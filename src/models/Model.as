package models
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import utils.Scrambler;
	
	public class Model extends EventDispatcher
	{
		public var texts:Vector.<String> = Vector.<String>([
			"A French maid was tidying up for a wealthy computer whiz. She commented that he had a nice PC. He looked frustrated and said, Yeah, it's top of the line, but I can't seem to get any programs to start up. You wouldn't happen to know how these gizmos work, do you? She replied, I'm sorry monsieur, I would love to help you, but oh la la, I don't do Windows!",
			"A blonde was telling a brunette that her computer broke. So the brunette said she would check the blonde's e-mail for her. The blonde said, Cool! E-mail me and tell me what I got.",
			"Bill Gates is hanging out with the chairman of General Motors. If automotive technology had kept pace with computer technology over the past few decades, boasts Gates, you would now be driving a V-32 instead of a V-8, and it would have a top speed of 10,000 miles per hour. Or, you could have an economy car that weighs 30 pounds and gets a thousand miles to a gallon of gas. In either case, the sticker price of a new car would be less than $50. Sure, says the GM chairman. But would you really want to drive a car that crashes four times a day?"
		]);
		
		private var _scrambleStrength:int = 0;
		private var _currentTextIndex:int = -1;
		private var _currentOrigText:String;
		private var _currentScrambledText:String;
		
		private var scrambler:Scrambler;
		
		public function Model()
		{
			scrambler = new Scrambler();
		}
		
		[Bindable]
		public function get scrambleStrength():int
		{
			return _scrambleStrength;
		}
		
		public function set scrambleStrength(value:int):void
		{
			if (value == _scrambleStrength)
				return;
			
			scrambler.maxRadius = _scrambleStrength = value;
			renderText();
			
			//		dispatchEvent(new Event("scrambleStrengthChanged"));
		}
		
		[Bindable]
		public function get currentTextIndex():int
		{
			return _currentTextIndex;
		}
		
		public function set currentTextIndex(value:int):void
		{
			if (value == _currentTextIndex)
				return;
			
			scrambleStrength = 5;
			
			_currentTextIndex = value;
			if (value >= 0 && value < texts.length)
				currentOrigText = texts[value];
			else
				currentOrigText = "";
		}
		
		[Bindable]
		public function get currentOrigText():String
		{
			return _currentOrigText;
		}
		
		public function set currentOrigText(value:String):void
		{
			if (value == _currentOrigText)
				return;
			
			_currentOrigText = value;
			renderText();
		}
		
		[Bindable(event="currentScrambledTextChange")]
		public function get currentScrambledText():String
		{
			return _currentScrambledText;
		}
		
		private function renderText():void
		{
			if (currentOrigText)
				
				_currentScrambledText = scrambleStrength ?
					scrambler.scramble(currentOrigText) :
					currentOrigText;
			else
				_currentScrambledText = "";
			
			dispatchEvent(new Event("currentScrambledTextChange"));
		}
	}
}