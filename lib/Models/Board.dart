import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';
class Board{
    List<List<int>> winningCombinations = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
    ];
    Map<List<int>,bool> selectedIndices = {};

    Board(){
      setIndices();
    }

    void setIndices(){

      for(List<int> elements in winningCombinations){
        selectedIndices[elements] = false;
      }

    }

  Map<List<int>, bool> getIndices(){
    return selectedIndices;
  }
  resetBoard(){
    selectedIndices = {};
  }

   String checkWinner(List<String> board){

    if (!board.contains('')){
      return 'Draw';
    }else{
      for (List<int> combinations in winningCombinations) {
       if(selectedIndices[combinations] == false){
         if (board[combinations[0]] != ''
             &&
             board[combinations[0]] == board[combinations[1]]
             &&
             board[combinations[1]] == board[combinations[2]]
         ) {
           selectedIndices[combinations] = true;
           print(selectedIndices);
           return board[combinations[0]]; //return either 'X' or 'O'

         }
       }
      }

    }
    return ''; // No winner yet
  }

}