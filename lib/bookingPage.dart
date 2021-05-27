import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keviiapp/bookingPagePanel.dart';
import 'package:keviiapp/venuePanel.dart';

import 'signup.dart';

class bookingPage extends StatelessWidget {
  final title = "Book A Facility";
  final CollectionReference _bookings = FirebaseFirestore.instance.collection("Facilities");
  bookingPage();
  List<dynamic> stuff = [];

  getDoc() async {
    _bookings.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        return (result.data().values.first.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF820312),
      appBar: AppBar(
        backgroundColor: Color(0xFF820312),
        elevation: 0.0,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.w600,
            fontSize: 30.0,
            fontFamily: 'Montserrat',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.amber,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                        (Route<dynamic> route) => false);
              });
            },
          )
        ],
      ),
      body: Padding (
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0,),
            Text("Current Bookings",
              style: TextStyle(
              color: Colors.amber,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w800,
              fontSize: 30.0,
            ),),
            SizedBox(height: 20.0,),
            Text(getDoc().toString()),
            Expanded(child: SizedBox(
              height: 200.0,
                child: new ListView(
                  scrollDirection: Axis.vertical,
                  children: [bookingPagePanel("Venue")],
                  /*
                  children: [bookingPagePanel(
                      _bookings.get().then((querySnapshot) {
                        querySnapshot.docs.
                        })
                      })
                  )],
                  
                   */
                ),
            ))
            /*Container(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  //venuePanel()
                ],
              ),
            )

             */
          ],
        )
      )
    );
  }
}