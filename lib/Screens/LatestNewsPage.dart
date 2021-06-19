import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../colorScheme.dart';
import '../signup.dart';
import 'email_login.dart';
import 'home.dart';

class LatestNewsPage extends StatelessWidget {
  String headline, subheading, news, imageURL;
  final title = 'Latest News';
  LatestNewsPage(this.headline, this.subheading, this.news, this.imageURL);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    imageURL,
                    alignment: Alignment.topLeft,
                    fit: BoxFit.fitWidth,
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
                            SizedBox(height: 5,),
                            Center(
                                child: Text(
                                  headline,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: KERed),
                                ),
                              ),
                            SizedBox(height: 20,),
                            Center(
                              child: Text(
                                subheading,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: KEYellow),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: KELightRed
                              ),
                              child: Text(
                                  news,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                          ],
                        )),
                  ),
              ],
            )
          ],
        ));
  }
}