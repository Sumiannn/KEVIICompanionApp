import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/colorScheme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../email_login.dart';
import '../home.dart';

class HallHistoryPart3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SlidingUpPanel(
            minHeight: 485.0,
            maxHeight: MediaQuery.of(context).size.height,
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
                    "assets/image/KingEdwardOld.jpg",
                    alignment: Alignment.topLeft,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 15,
                  child: IconButton(
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
                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.signOut().then((res) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmailLogIn()),
                                (Route<dynamic> route) => false);
                      });
                    },
                  ),
                ),
              ],
            )));
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
        Positioned(
          top: 230,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: bgColor,
              ),
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "King Edward VII Hall",
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
                      "Sepoy Lines, 12 College Road (1957-1987)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: KEYellow),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: KELightRed),
                    child: Text(
                      "On 30th November 1957, a new hostel was declared open by the Prime Minister of Malaya, Tunku Abdul Rahman. The new Hall of Residence was named “King Edward VII Hall” in honour of the old KEVII College of Medicine, which had ceased to exist as it had become the Faculty of Medicine for the University of Malaya. The Hall housed more than 250 students in two blocks.",
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              )),
        ),
      ]
  );
}

