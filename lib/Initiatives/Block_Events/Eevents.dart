import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../colorScheme.dart';
import '../../SignInSignUp/email_login.dart';
import '../../HomePage/home.dart';

class Eevents extends StatelessWidget {
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
              left: 15,
              child: IconButton(
                key: Key('Back Button'),
                icon: Icon(Icons.arrow_back_rounded, color: Color(0xFFAE0700), size: 30),
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
                "E Block",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFAE0700)),
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
                  "Hey E Blockers! Look at what your Block Committee has in store for you guys!",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFAE0700)),
                ),
              ),
            ),
            Positioned.fill(
              top: 200,
              child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Block Events')
                          .where('Block', isEqualTo: 'E').orderBy('Timestamp')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.data.docs.length == 0) {
                          return Center(
                            child: Text(
                              'Hang on! Your Block Committee is still in the process of planning some exciting stuff for you!',
                              style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: EColor,),
                              textAlign: TextAlign.center,
                            ),
                          );
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
                                                    fontSize: 23,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: KERed),
                                                textAlign: TextAlign.left,
                                              ))),
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
                                              doc['Date'],
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: KEYellow,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Sign-Up Method:',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(doc['Sign Up Method'],
                                                style: TextStyle(fontSize: 16))
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
                                ),
                                doc['Sign Up Link'] != 'None'
                                    ? Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _launchURL(doc['Sign Up Link']);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ABColor)),
                                    child: Text("Sign Up Here",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: KERed,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                )
                                    : SizedBox()
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
                                MediaQuery.of(context).size.height * 0.65,
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
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
    paint.color = EColor;

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