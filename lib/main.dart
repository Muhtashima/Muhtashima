import 'package:flutter/material.dart';
import 'package:sec_pro/Pages/HomePage.dart';
import 'package:sec_pro/Pages/TicTacToe.dart';


void main(){
  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context){return HomePage();},
        '/board':(context){return Tictactoe();},
        '/achievements':(context){return ProfilePage();},
      },
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.white54,),);
  }
}




