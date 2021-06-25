import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'CommitteeCCA.dart';
import 'CulturalCCA.dart';
import 'SportsCCA.dart';
import '../colorScheme.dart';
import '../SignInSignUp/email_login.dart';
import '../HomePage/home.dart';

class CCAInfo extends StatelessWidget {
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
                "CCA Information",
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
                  "Our CCAs are categorised into 3 main categories! Click any to check out the various CCAs!",
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: KERed),
                ),
              ),
            ),
            Positioned(
              top: 230,
              left: 20,
              right: 20,
              child: InkWell(
                key: Key('Committee CCA Button'),
                onTap: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => CommitteeCCA())
                  );
                },
                child:
                    CcaCategory('assets/image/CommitteeCca.png', 'Committee'),
                ),
              ),
            Positioned(
              top: 400,
              left: 20,
                right: 20,
              child: InkWell(
                key: Key('Cultural CCA Button'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => CulturalCCA())
                  );
                },
                child: CcaCategory('assets/image/CulturalCca1.png', 'Cultural'),
              ),
            ),
            Positioned(
              top: 570,
              left: 20,
              right: 20,
              child: InkWell(
                key: Key('Sports CCA Button'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => SportsCCA())
                  );
                },
                child: CcaCategory('assets/image/SportCCA.png', 'Sports'),
              ),
            )

          ]
      ),
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



