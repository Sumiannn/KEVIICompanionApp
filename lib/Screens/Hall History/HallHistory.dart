import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Screens/Hall%20History/HallHistoryPart1.dart';

import '../../HallInfoOptionScreen.dart';
import '../../colorScheme.dart';
import '../email_login.dart';
import '../home.dart';
import 'HallHistoryPart2.dart';
import 'HallHistoryPart3.dart';
import 'HallHistoryPart4.dart';


class HallHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: PathPainter(),
          ),
        ),
        Positioned(
          top: 25,
          left: 15,
          child: IconButton(
            icon: Icon(Icons.arrow_back_rounded, color: KERed, size: 30),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          top: 25,
          right: 55,
          child: IconButton(
            icon: Icon(Icons.home_rounded, color: KERed, size: 30),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false);
            },
          ),
        ),
        Positioned(
          top: 25,
          right: 15,
          child: IconButton(
            icon: Icon(
              Icons.exit_to_app_rounded,
              color: KERed,
              size: 30,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => EmailLogIn()),
                    (Route<dynamic> route) => false);
              });
            },
          ),
        ),
        Positioned(
          top: 75,
          left: 25,
          child: Text(
            "Hall History",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: KERed),
          ),
        ),
        Positioned(
          top: 125,
          left: 25,
          right: 25,
          child: Container(
            padding: EdgeInsets.only(right: 12),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "History of King Edward VII Hall",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: KERed),
            ),
          ),
        ),
        Positioned(
            top: 200,
            left: 10,
            right: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              margin: EdgeInsets.only(top: 10.0),
              child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/image/KingEdwardFMS.jpg',
                            width: 170,
                          ),
                          SizedBox(width: 10.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF8CF3E),
                            ),
                            child: Container(
                                width: 160.0,
                                height: 115.0,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 2.0),
                                    Text("Federated Malay States Hostel",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: Colors.black)),
                                    SizedBox(height: 5.0),
                                    Text("Sepoy Lines (1916-1956)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15,
                                            color: Colors.black)),
                                    SizedBox(height: 10.0),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text("view more >>"),
                                    )
                                  ],
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HallHistoryPart1()));
                            },
                          ),
                        ]),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/image/KingEdwardHolneChase.jpg',
                            width: 170,
                          ),
                          SizedBox(width: 10.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF8CF3E),
                            ),
                            child: Container(
                                width: 160.0,
                                height: 115.0,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 2.0),
                                    Text("Holne Chase",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: Colors.black)),
                                    SizedBox(height: 5.0),
                                    Text("Grange Road (1938-1956)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15,
                                            color: Colors.black)),
                                    SizedBox(height: 25.0),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text("view more >>"),
                                    )
                                  ],
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HallHistoryPart2()));
                            },
                          ),
                        ]),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/image/KingEdwardOld.jpg',
                            width: 170,
                          ),
                          SizedBox(width: 10.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF8CF3E),
                            ),
                            child: Container(
                                width: 160.0,
                                height: 115.0,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 2.0),
                                    Text("King Edward VII Hall",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: Colors.black)),
                                    SizedBox(height: 5.0),
                                    Text(
                                        "Sepoy Lines, 12 College Road (1957-1987)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15,
                                            color: Colors.black)),
                                    SizedBox(height: 10.0),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text("view more >>"),
                                    )
                                  ],
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HallHistoryPart3()));
                            },
                          ),
                        ]),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/image/KE7HallHistory.jpg',
                            width: 170,
                          ),
                          SizedBox(width: 10.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF8CF3E),
                            ),
                            child: Container(
                                width: 160.0,
                                height: 115.0,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 2.0),
                                    Text("King Edward VII Hall",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: Colors.black)),
                                    SizedBox(height: 5.0),
                                    Text("1A Kent Ridge Road (1987-Present)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15,
                                            color: Colors.black)),
                                    SizedBox(height: 25.0),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text("view more >>"),
                                    )
                                  ],
                                )),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HallHistoryPart4()));
                            },
                          ),
                        ]),
                  ]),
            ))
      ]),
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = KELightYellow;

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

Container categoryContainer(String imgName, String title) {
  return Container(
      width: 130,
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/image/$imgName',
            height: 150.0,
            width: 150.0,
          ),
          Text(
            "$title",
            style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 17, color: Colors.black),
          )
        ],
      ));
}
