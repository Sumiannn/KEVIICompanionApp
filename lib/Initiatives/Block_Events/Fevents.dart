import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/HallInfo/CCA_Info/CommitteeCCA.dart';
import 'package:keviiapp/HallInfo/CCA_Info/CulturalCCA.dart';
import 'package:keviiapp/HallInfo/CCA_Info/SportsCCA.dart';
import 'package:keviiapp/HallInfo/Hall_History/HallHistory.dart';


import '../../colorScheme.dart';
import '../../SignInSignUp/email_login.dart';
import '../../HomePage/home.dart';

class Fevents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget CcaCategory(String Img, String Category) {
      return Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: KELightRed,
        ),
        child: Row(
          children: [
            Image.asset(Img, fit: BoxFit.fitHeight,),
            SizedBox(width:20),
            Center(
              child: Text(
                Category, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: KERed),
              ),
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
                "F Block",
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
                  "Bonjour F Blockers! :)",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: KERed),
                ),
              ),
            ),
            Positioned(
              top: 150,
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

                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10, top: 5, left: 10),
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.89,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                "(: F Events :)",
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
            Positioned.fill(
              top: 260,
              child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Block Events')
                          .where('Block', isEqualTo: 'F')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.data.docs.length == 0) {
                          return Text('Loading Please Wait');
                        }
                        List<Tab> tabs = [];
                        List<Widget> tabBarViews = [];

                        snapshot.data.docs.forEach((doc) {
                          tabs.add(Tab(text: doc['Block Event Name']));
                          tabBarViews.add(
                            ListView(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      doc['ImageURL'],
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.22,
                                      width:
                                      MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                  decoration:
                                  BoxDecoration(color: KELightYellow),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height *
                                      0.13,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height*0.005),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.9,
                                          child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                doc['Block Event Name'],
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: KERed),
                                                textAlign: TextAlign.left,
                                              ))),
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height*0.010),
                                      Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.9,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Sign-Up Link:',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            Text(doc['Sign Up Link'],
                                                style:
                                                TextStyle(fontSize: 16))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                  decoration:
                                  BoxDecoration(color: KELightYellow),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: KELightRed,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    doc['Description'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: KERed,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                        return DefaultTabController(
                          length: snapshot.data.docs.length,
                          child: Column(
                            children: [
                              TabBar(
                                isScrollable: true,
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600),
                                indicatorColor: KEYellow,
                                unselectedLabelColor: KELightRed,
                                labelColor: KERed,
                                labelPadding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                                tabs: tabs,
                              ),
                              Container(
                                height:
                                MediaQuery.of(context).size.height * 0.57,
                                child: TabBarView(
                                    key: Key('tabBarView'),
                                    children: tabBarViews),
                              )

                            ],
                          ),
                        );
                      })),
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