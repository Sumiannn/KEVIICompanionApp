import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/HallInfo/CCA_Info/CommitteeCCA.dart';
import 'package:keviiapp/HallInfo/CCA_Info/CulturalCCA.dart';
import 'package:keviiapp/HallInfo/CCA_Info/SportsCCA.dart';
import 'package:keviiapp/HallInfo/Hall_History/HallHistory.dart';
import 'package:keviiapp/Initiatives/Block_Events/ABevents.dart';

import '../../colorScheme.dart';
import '../../SignInSignUp/email_login.dart';
import '../../HomePage/home.dart';
import 'CDevents.dart';
import 'Eevents.dart';
import 'Fevents.dart';
import 'GHevents.dart';

class BlockEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Container BlockContainer(String imgPath, String title) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          children: <Widget>[
            Image.asset(
              imgPath,
            ),
            Text(
              "$title",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  color: KERed),
            )
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
          children: [
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
                  logOutNotice(context);
                },
              ),
            ),
            Positioned(
              top: 75,
              left: 25,
              child: Text(
                "Block Events",
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
                  "Which Block are you from? Check out our latest Block Events for the various Blocks! :)",
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
                  height: MediaQuery.of(context).size.height*0.71,
                  margin: EdgeInsets.only(top: 10.0),
                  child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ABevents()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10, top: 5, left: 10),
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.89,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ABColor,
                            ),
                            child: Center(
                              child: Text(
                                "AB",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CDevents()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10, top: 5, left: 10),
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.89,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CDColor,
                            ),
                            child: Center(
                              child: Text(
                                "CD",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        InkWell(
                          key: Key('Block Events Button'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Eevents()));
                          },
                          child: BlockContainer('assets/image/Blocks/EBlock.png', 'E Block')
                        ),
                        SizedBox(height: 25),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Fevents()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10, top: 5, left: 10),
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.89,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: FColor,
                            ),
                            child: Center(
                              child: Text(
                                "F",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GHevents()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10, top: 5, left: 10),
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.89,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: GHColor,
                            ),
                            child: Center(
                              child: Text(
                                "GH",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ])
              ),
            ),
          ]
      ),
    );
  }

  void logOutNotice(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Are you sure you want to Log Out?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print("Cancel");
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel', style: TextStyle(color: Colors.black),),
        ),
        FlatButton(
          onPressed: () {
            print("Logout");
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.signOut().then((res) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => EmailLogIn()),
                      (Route<dynamic> route) => false);
            });
          },
          child: Text('Logout', style: TextStyle(color: Colors.black),),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
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
