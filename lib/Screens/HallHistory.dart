import 'package:flutter/material.dart';

class HallHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Garen, The Might of Demacia",
              style: TextStyle(fontFamily: 'Raleway')
          ),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Text('Hello there', style: TextStyle(fontSize: 30.0),),
        )
    );
  }
}

