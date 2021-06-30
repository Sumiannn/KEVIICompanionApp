import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/colorScheme.dart';

import 'CCAInfo.dart';
import 'Hall_History/HallHistory.dart';
import 'RoomInfo.dart';
import '../SignInSignUp/email_login.dart';
import '../HomePage/home.dart';

class HallInfoOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
              painter: pathPainter(),
            ),
          ),
          Positioned(
            top: 25,
            left: 15,
            child: IconButton(
              key: Key('Back Button'),
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
              "Hall Information",
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
                "New to KE7? Or simply want to know more about our Hall? Here's all things you need to know!",
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
            left: 25,
            right: 25,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.73,
                margin: EdgeInsets.only(top: 10.0),
                child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                        InkWell(
                          key: Key('Hall History Button'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HallHistory(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10, top: 5, left: 10),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.89,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image:
                                  AssetImage('assets/image/KE7HallHistory.jpg'),
                                  fit: BoxFit.cover),
                            ),
                            child: Center(
                              child: Text(
                                "Hall History",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color: bgColor),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                      InkWell(
                        key: Key('CCA Info Button'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CCAInfo(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 10, top: 5, left: 10),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.89,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/image/CheckBookingsImage.jpg'),
                                fit: BoxFit.cover),
                          ),
                          child: Center(
                            child: Text(
                              "CCA Information",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700,
                                  color: bgColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RoomInfo(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 10, top: 5, left: 10),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.89,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/image/KE7HallRoom.png'),
                                fit: BoxFit.cover),
                          ),
                          child: Center(
                            child: Text(
                              "Room Information",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w700,
                                  color: bgColor),
                            ),
                          ),
                        ),
                      ),
                    ])
            ),
          ),
        ],
      ),
    );
  }
}

class pathPainter extends CustomPainter {
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
