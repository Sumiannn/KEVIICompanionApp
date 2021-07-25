import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/colorScheme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../SignInSignUp/email_login.dart';
import '../../HomePage/home.dart';

class HallHistoryPart2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SlidingUpPanel(
            minHeight: MediaQuery.of(context).size.height*0.69,
            maxHeight: MediaQuery.of(context).size.height*0.69,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            panelBuilder: (scrollController) => buildSlidingPanel(
              scrollController: scrollController,
            ),
            body: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/image/KingEdwardHolneChase.jpg",
                    alignment: Alignment.topLeft,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 15,
                  child: IconButton(
                    key: Key('Back Button'),
                    icon:
                    Icon(Icons.arrow_back_rounded, color: KERed, size: 30),
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
              ],
            )));
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

  Widget buildSlidingPanel({
    @required ScrollController scrollController,
  }) =>
      TabWidget(scrollController: scrollController);
}

class TabWidget extends StatelessWidget {
  const TabWidget({
    Key key,
    @required this.scrollController,
  }) : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => ListView(
      padding: EdgeInsets.all(0),
      controller: scrollController,
      children: [
        Container(
            height: MediaQuery.of(context).size.height*0.50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: bgColor,
            ),
            child: ListView(
              key: Key('History Page'),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    "Holne Chase",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: KERed),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Grange Road (1938-1956)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: KEYellow),
                  ),
                ),
                Container(
                  key: Key('Long Text'),
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: KELightRed),
                  child: Text(
                    "Female students during the F.M.S. years stayed in a bungalow at Grange Road, quaintly called “Holne Chase”, an all-female hostel. The grounds were beautiful with huge trees and flowering shrubs. There were also tennis and badminton courts.",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )),
      ]
  );
}

