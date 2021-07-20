import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Facilities/FacilitiesOptionScreen.dart';
import 'package:keviiapp/HallInfo/HallInfoOptionScreen.dart';
import 'package:keviiapp/Facilities/AddBooking.dart';

import 'package:keviiapp/Initiatives/InitiativesOptionScreen.dart';

import 'package:keviiapp/Initiatives/InitiativeOptionsPage.dart';

import 'package:keviiapp/Panels/homePanel.dart';
import 'package:keviiapp/Facilities/FacilitiesBookingPage.dart';
import 'package:keviiapp/AccountPage/accountPage.dart';
import 'package:keviiapp/colorScheme.dart';

import '../Facilities/AddBooking.dart';
import '../Latestnews/LatestNewsPage.dart';
import '../SignInSignUp/email_login.dart';

class Home extends StatefulWidget {
  Home({this.uid});

  final String uid;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final String title = "KEVII Community";
  User user = FirebaseAuth.instance.currentUser;
  int _currentIndex = 0;

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
              painter: PathPainter(),
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
              key: Key('Sign out button'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        "Welcome ",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: KERed,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }
                    Map<String, dynamic> data = snapshot.data.data();
                    return Text(
                      "Welcome ${data['first name']}!",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: KERed,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 135,
            left: 25,
            child: Container(
                key: Key('Home sliding panel'),
                width: MediaQuery.of(context).size.width*0.9,
                height: 150,
                margin: EdgeInsets.only(top: 10),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      key: Key('Facilities Button'),
                      child: categoryContainer(
                          "FacilitiesImage.png", "Facilities"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FacilitiesOptionsScreen()));
                      },
                    ),
                    InkWell(
                      key: Key('Hall Info Button'),
                      child:
                          categoryContainer("HallInfoImage.png", "Hall Info"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HallInfoOptionScreen()));
                      },
                    ),
                    InkWell(
                      key: Key('Student Initiatives Button'),
                      child: categoryContainer("Initiatives.png", "Initiatives"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InitiativeOptionsPage()));
                      },


                    ),
                    InkWell(
                      key: Key('Account Info Button'),
                      child: categoryContainer("AccountImage.png", "Account"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => accountPage()));
                      },
                    ),
                  ],
                )),
          ),
          Positioned(
            top: 340,
            left: 25,
            child: Text(
              "Latest News",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: KERed),
            ),
          ),
          Positioned(
              top: 370,
              left: 25,
              child: Container(
                  key: Key('Latest News Panel'),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.875,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Home Panel News')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading please wait');
                      }
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = snapshot.data.docs[index];
                          return homePanel(
                              document['ImageURL'],
                              document['Headline'],
                              document['Subheading'],
                              document['News'],
                              LatestNewsPage(
                                  document['Headline'],
                                  document['Subheading'],
                                  document['News'],
                                  document['ImageURL']));
                        },
                      );
                    },
                  ))),
        ],
      ),
    );
  }

  void logOutNotice(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text("Are you sure you want to Log Out?", style: TextStyle(fontWeight: FontWeight.bold, color: KERed),),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print("Cancel");
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: KERed),),
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
          child: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, color: KERed),),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Container categoryContainer(String imgName, String title) {
    return Container(
      width: 130,
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/image/$imgName',
            scale: 0.7,
          ),
          Text(
            "$title",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: KERed),
          )
        ],
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = KELightRed;

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
