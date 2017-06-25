package{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.*;
	
	public class Main extends MovieClip{
		
		var turn;
		
		
		public function Main(){
			init();
		}
		
		function init():void {
			
			//Initially the turn is set for Player 1
			turn = "player1";
			statusTxt.text = "Player 1's Turn!";
			
			//clear all the places and make them clickable
			for (var i=1; i<=9; i++){
				this["place"+i].gotoAndStop(1);
				this["place"+i].buttonMode = true;
				this["place"+i].addEventListener(MouseEvent.CLICK, placeClicked);
			}
			
		}
		
		//This function will be called if any of the place is clicked
		function placeClicked(event:MouseEvent){
			
			var tmpPlace = event.currentTarget as Place; 
			
			if(turn == "player1"){
				//insert symbol o
				tmpPlace.gotoAndStop(2);
				
				//set turn for player 2
				turn = "player2";
				statusTxt.text = "Player 2's Turn!";
			}else if(turn == "player2"){
				//insert symbol x
				tmpPlace.gotoAndStop(3);
				
				//set turn for player 1
				turn = "player1";
				statusTxt.text = "Player 1's Turn!";
			}
			
			//Make the place non clickable
			tmpPlace.buttonMode = false;
			tmpPlace.removeEventListener(MouseEvent.CLICK, placeClicked);
			
			//check if the game was won after the previous turn
			checkWon();
		}
		
		function checkWon(){
			
			var gameWon = false;
			
			for(var i=2; i<=3; ++i){
				
				if(place1.currentFrame == i && place2.currentFrame == i && place3.currentFrame == i){
					gameWon = true;
				}else if(place4.currentFrame == i && place5.currentFrame ==i && place6.currentFrame == i){
					gameWon = true;
				}else if(place7.currentFrame == i && place8.currentFrame == i && place9.currentFrame == i){
					gameWon = true;
				}else if(place1.currentFrame == i && place4.currentFrame ==i && place7.currentFrame == i){
					gameWon = true;
				}else if(place2.currentFrame == i && place5.currentFrame ==i && place8.currentFrame == i){
					gameWon = true;
				}else if(place3.currentFrame == i && place6.currentFrame ==i && place9.currentFrame == i){
					gameWon = true;
				}else if(place1.currentFrame == i && place5.currentFrame == i && place9.currentFrame == i){
					gameWon = true;
				}else if(place3.currentFrame == i && place5.currentFrame == i && place7.currentFrame == i){
					gameWon = true;
				}
			}
			
			if(gameWon == true){
				if(turn == "player1"){
					statusTxt.text = "Player 2 won!\nClick to restart"
				}else if(turn == "player2"){
					statusTxt.text = "Player 1 won!\nClick to restart"
				}
				
				for (var i=1; i<=9; i++){
					this["place"+i].removeEventListener(MouseEvent.CLICK, placeClicked);
				}
				
				addEventListener(MouseEvent.MOUSE_DOWN, restartGame);
			}else{  //If the game is not won check if the game is draw
				checkDraw();
			}
			
		}
		
		function checkDraw(){
			
			var gameDraw = true;
			
			for (var i=1; i<=9; i++){
				if (this["place"+i].currentFrame == 1)
					gameDraw = false;
			}
			
			if(gameDraw == true){
				statusTxt.text = "Draw!\nClick to restart"
				
				for (var i=1; i<=9; i++){
					this["place"+i].removeEventListener(MouseEvent.CLICK, placeClicked);
				}
				
				addEventListener(MouseEvent.MOUSE_DOWN, restartGame);
			}
		}
		
		function restartGame(event:MouseEvent){
			removeEventListener(MouseEvent.MOUSE_DOWN, restartGame);
			init();
		}
		
	}
}