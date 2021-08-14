import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Facilities/ManageBookingsDataPanel.dart';
import 'package:keviiapp/HomePage/home.dart';
import 'package:keviiapp/SignInSignUp/email_login.dart';

import '../colorScheme.dart';

class ManageBookingsPage extends StatefulWidget {
  const ManageBookingsPage({Key key}) : super(key: key);

  @override
  _ManageBookingsPageState createState() => _ManageBookingsPageState();
}

class _ManageBookingsPageState extends State<ManageBookingsPage> {
  User user = FirebaseAuth.instance.currentUser;

  DateTime isNow() {
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      0,
      0,
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime Today = isNow();
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
              key: Key('Home Button'),
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
              key: Key('Sign Out Button'),
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
              "Manage My Bookings",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: KERed),
              key: Key('Manage Booking Header'),
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
                "You can see your existing bookings here! Click on the booking you want to edit them or view the details!",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: KERed),
                key: Key('Subheading'),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Positioned(
              top: 200,
              left: 25,
              right: 25,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.73,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Facilities')
                      .where('user', isEqualTo: user.uid)
                      .where('Start Time (Timestamp)',
                          isGreaterThanOrEqualTo: Timestamp.fromDate(Today))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data.docs.length == 0) {
                      return Center(
                          child: Text(
                        'No bookings made!',
                        style: TextStyle(
                            color: KERed,
                            fontWeight: FontWeight.w600,
                            fontSize: 40),
                        textAlign: TextAlign.center,
                      ));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot bookings = snapshot.data.docs[index];
                        return ManageBookingsDataPanel(
                          bookings['Venue'],
                          bookings['Date'],
                          bookings['Start time'],
                          bookings['End time'],
                          bookings['Start Time (Timestamp)'],
                          bookings['Number of Pax'],
                          bookings['CcaBlock'],
                          bookings['Reference Code'],
                        );
                      },
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }

  void logOutNotice(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        "Are you sure you want to Log Out?",
        style: TextStyle(fontWeight: FontWeight.bold, color: KERed),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            print("Cancel");
            Navigator.of(context).pop(false);
          },
          child: Text(
            'Cancel',
            style: TextStyle(fontWeight: FontWeight.bold, color: KERed),
          ),
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
          child: Text(
            'Logout',
            style: TextStyle(fontWeight: FontWeight.bold, color: KERed),
          ),
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
