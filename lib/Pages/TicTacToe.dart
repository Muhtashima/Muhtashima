import 'package:sec_pro/Models/Board.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
class Tictactoe extends StatefulWidget {
  const Tictactoe({super.key});

  @override
  State<Tictactoe> createState() => _TictactoeState();
}

class _TictactoeState extends State<Tictactoe> {
  Offset _underlineStart = Offset.zero;
  Offset _underLineEnd = Offset.zero;
  double _underlineWidth = 2.0;
  final List<GlobalKey> _keysIndex = List.generate(9, (index)=>GlobalKey());
  List<String> board = List.generate(9, (index)=>'');
  bool xTurn = false;

  String result = '';
  Map<List<int>, bool> selectedIndices = {};

  Board game = Board();
  bool _showAnimatedUnderLine = false;

  SnackBar createSnackbar(String message){
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
          label: 'Back to HomePage',
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          }
      ),
    );
    return snackBar;

  }
  Offset _findSizeAndPosition(int index){
    final RenderBox renderBox = _keysIndex[index].currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    print('Widget Size of index $index: $size');
    final Offset position = renderBox.localToGlobal(Offset.zero);
    print('Widget position of index $index: $position');
    return position;

  }

  List<List<int>> calculateTrueKeys(Map<List<int>,bool> selectedIndices){
    List<List<int>> _trueKeys = selectedIndices.entries
        .where((entry)=>entry.value == true)
        .map((entry)=>entry.key)
        .toList();

    print("These are the true keys : $_trueKeys");
    return _trueKeys;

  }
  void showWinnerDisplay(String result){
    String message = '';
    if (result.isNotEmpty){
      if (result == 'Draw'){
        message = 'It\'s a draw';
      }

      if(result == 'X' || result == 'O') {
        message = 'Player $result wins';
      }
      result='';
      ScaffoldMessenger.of(context).showSnackBar(createSnackbar(message));

    }
  }
  List<Widget> calculateLineOffsets(Map<List<int>,bool> selectedIndices){
    List<List<int>> _trueKeys = calculateTrueKeys(selectedIndices);
    List<Offset> _underlineOffsets = [];
    List<Widget> _animatedlineList = [];
    for(List<int> keys in _trueKeys){
      _underlineStart = _findSizeAndPosition(keys[0]);
      _underLineEnd = _findSizeAndPosition(keys[2]);
      var _lineDx = _underLineEnd.dx - _underlineStart.dx;
      var _lineDy = _underLineEnd.dy - _underlineStart.dy;
      final Offset _underlinePosition = Offset(_lineDx, _lineDy);
      //Determine where the underline should be horizontal,vertical or diagonal
      //if [0,1,2], [3,4,5], [6,7,8] , then _underline horizontal if [0,3,6], [1,4,7], [2,5,8] then _underline vertical [0,4,8] [2,4,6[ then underline diagonal
      if (ListEquality().equals(keys, [0,1,2])
          ||
          ListEquality().equals(keys, [3,4,5])
          ||
          ListEquality().equals(keys, [6,7,8])){
        print('Underline position $_underlinePosition');
        AnimatedPositioned animatedCross = AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            height: 12,
            width: 434,
            top: _underLineEnd.dy - 133.3,
            child: Container(
              color: Colors.red,
            )

        );
        _animatedlineList.add(animatedCross);
        _underlineOffsets.add(_underlinePosition);
      }
      else if(
          ListEquality().equals(keys, [0,3,6])
          ||
          ListEquality().equals(keys, [1,4,7])
          ||
          ListEquality().equals(keys, [2,5,8])
      ){

        print('Underline position $_underlinePosition');

        AnimatedPositioned animatedCross = AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            height: 434,
            width: 12,
            left: _underLineEnd.dx + 133.3/2,
            child: Container(
              color: Colors.red,
            )

        );
        _underlineOffsets.add(_underlinePosition);
        _animatedlineList.add(animatedCross);

      }
      else if(
      ListEquality().equals(keys, [0,4,8])
      || ListEquality().equals(keys, [2,4,6])
      ){
        bool lefttoRight  = ListEquality().equals(keys, [0,4,8]);
        print('Underline position $_underlinePosition');


        Transform _transformedAnimatedCrossRightToLeft = Transform.translate(offset: Offset(-76, -256),
        child: Transform.rotate(
            angle: 2.35,
            alignment: Alignment.center,
            child:Container(
              height: 12,
              width: 600,
              color: Colors.red,
            )
        ),);

        Transform _transformedAnimatedCrossLeftToRight = Transform.translate(offset: Offset(-75, -270),
          child: Transform.rotate(
              angle: 0.785398,
              alignment: Alignment.center,
              child:Container(
                height: 12,
                width: 600,
                color: Colors.red,
              )
          ),);

        AnimatedPositioned animatedCross = AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: _underLineEnd.dy,
          child: lefttoRight ? _transformedAnimatedCrossLeftToRight : _transformedAnimatedCrossRightToLeft,


        );
        _underlineOffsets.add(_underlinePosition);
        _animatedlineList.add(animatedCross);
      }

    }
    return _animatedlineList;
    //return Offset.zero;
  }

  List<Widget> animatedUnderline(String winner, Map<List<int>,bool> selectedIndices){
    //Print accessed
    print('Accessed this animatedUnderline method');

    //List<Offset> underlineList =  calculateLineOffsets(selectedIndices);
    List<Widget> _animatedlineList = calculateLineOffsets(selectedIndices);
    print('Number of widgets : ${_animatedlineList.length}');
    return _animatedlineList;

  }

  @override
  Widget build(BuildContext context) {
    //double screenHeight =  MediaQuery.sizeOf(context).height;
    //double screenWidth =  MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: PreferredSize(preferredSize: Size.fromHeight(40.0),
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
            child: AppBar(title: Text('Board'),backgroundColor: Colors.grey,),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 110.0),
        child: Stack(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    key: _keysIndex[index],
                    onTap: (){
                      //_findSizeAndPosition(index);
                      setState(() {
                        if (board[index] == ''){
                          board[index] = xTurn ? 'X':'O';
                          xTurn = !xTurn;
                        }
                      });
                      //Show Snackbar and Underline the pathway for winner
                      result = game.checkWinner(board);
                      if(result == 'X' || result =='O'){
                        setState(() {
                          _showAnimatedUnderLine = true;
                        });
                      }
                      showWinnerDisplay(result);
                      selectedIndices = game.getIndices();
                    },
                    child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black54, width: 2.0)),
                        child: Center(
                            child: Text(
                              board[index],
                              style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold,color: Colors.purpleAccent),
                            )
                        )
                    ),
                  ),
                );
              },
            ),


            //Here call UnderLine Animated Widget to cross winning paths
            if(_showAnimatedUnderLine) ...animatedUnderline(result, selectedIndices),

          ],
        ),
      ),
    );
  }
}





