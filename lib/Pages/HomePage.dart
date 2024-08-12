import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('This is a Sample App'),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
        leading: Container(
          margin: EdgeInsets.all(4.0),
          child: SvgPicture.asset('assets/icons/left-arrows-svgrepo-com.svg'),
          decoration: BoxDecoration(
            color: Colors.grey,
            image: ,
            borderRadius: BorderRadius.circular(20.0)
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Sample Text 1'),
          Text('Sample Text 2'),
          Text('Sample Text 3')

        ],
      )
    );
  }
}
