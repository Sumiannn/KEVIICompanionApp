import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Panels/bookingPagePanel.dart';
import 'package:keviiapp/signup.dart';

class FacilitiesBookingPage extends StatelessWidget {
  final title = "Check current bookings";
  FacilitiesBookingPage();
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
            fontSize: 22.0,
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Facilities").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot bookings = snapshot.data.docs[index];
                return bookingPagePanel(
                    bookings['Venue'], bookings['Date'], bookings['Time']);
              },
            );
          }
          return Text('No bookings currently');
        }
      ),
    );
  }
}
