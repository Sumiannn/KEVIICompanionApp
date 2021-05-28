
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/signup.dart';

class AddBooking extends StatefulWidget {
  const AddBooking({Key key}) : super(key: key);

  @override
  _AddBookingState createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  _AddBookingState();
  String title = 'Add a Booking', venueChoose;
  List venueList = ["MPC", "Comm Hall", "Dance Studio", "Dining Hall"];

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              border: Border.all(color: Colors.amber, width: 1.0),
            ),
            child: DropdownButton(
              hint: Text('Choose Venue'),
              dropdownColor: Colors.grey,
              icon: Icon(Icons.arrow_drop_down_circle_sharp),
              iconSize: 36,
              isExpanded: true,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 22.0,
              ),
              value: venueChoose,
              onChanged: (newValue) {
                setState(() {
                  venueChoose = newValue;
                });
              },
              items: venueList.map((venueItem){
                return DropdownMenuItem(
                  value: venueItem,
                child: Text(venueItem),
              );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
