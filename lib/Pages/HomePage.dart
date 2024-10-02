
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sec_pro/Models/Board.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 5.0,
        title: Text('Let\'s play Tic-Tac-toe'),
        centerTitle: true,
        backgroundColor: Colors.white54,
      ),
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: (){
                 Navigator.pushNamed(context, '/board');
                 Board().resetBoard();
                 print('This button will redirect you to game page');
              }, child: Text('New Game')),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/achievements');
                print('This will take you the achievements board');
              }, child: Text('Achievements')),
              ElevatedButton(onPressed: (){
                SystemNavigator.pop();
                print('This will exit the app');
              }, child: Text('Quit')),

            ],
          ),
        ),
      )
    );
  }
}
