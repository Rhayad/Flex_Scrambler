package utils
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Scrambler extends EventDispatcher
	{
		public var maxRadius:int = 2;
		
		private const SAVE_CHAR_GROUPS:Array =
			[
				"mm",
				"ll",
				"tt",
				"ch",
				"sch",
			];
		
		public function Scrambler(target:IEventDispatcher = null)
		{
			super(target);
		}
		
		public function scramble(origText:String):String
		{
			return origText.replace(/[a-zäöüÄÖÜß]{4,}/gi, scrambleWord);
		}
		
		private function scrambleWord(word:String,... args):String
		{
			var scrambledWord:String = word;
			
			for (var i:int = 0; i < maxRadius; i++) {
				scrambledWord = switchTwoRandomChars(scrambledWord);
			}
			
			return scrambledWord;
		}
		
		private function switchTwoRandomChars (word:String):String {
			var firstCharIndex:int = randomNumberBetween(1,word.length-2);
			var secondCharIndex:int = randomNumberBetween(1,word.length-2);
			
			if (firstCharIndex > secondCharIndex) {
				var temp:int = firstCharIndex;
				firstCharIndex = secondCharIndex;
				secondCharIndex = temp;
			}
			
			var tempScrambledWord:String = "" ;
			
			for (var i:int = 0; i< word.length; i++) {
				if (i == firstCharIndex) {
					tempScrambledWord += word.charAt(secondCharIndex);
				} else if ( i == secondCharIndex) {
					tempScrambledWord += word.charAt(firstCharIndex);
				} else tempScrambledWord += word.charAt(i);
			}
			
			return tempScrambledWord;
		
		}
		
		public static function randomNumberBetween (low:Number, high:Number):int {
			return Math.floor(low + (Math.random() * (high - low + 1)));
		}
	}
}