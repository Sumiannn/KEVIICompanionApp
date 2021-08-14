import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/AccountPage/editAccount.dart';
import 'package:keviiapp/Facilities/ManageBookingsPage.dart';
import 'package:keviiapp/colorScheme.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../SignInSignUp/email_login.dart';
import '../HomePage/home.dart';
import 'avatar.dart';

class accountPage extends StatefulWidget {
  accountPage();

  @override
  _accountPageState createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {
  bool isObscurePassword = true;
  User user = FirebaseAuth.instance.currentUser;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  String avatarURL;
  TextEditingController emailController = TextEditingController(),
      roomController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    downloadURLExample();
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        fit: StackFit.expand,
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
            bottom: MediaQuery.of(context).size.height * 0.045,
            left: MediaQuery.of(context).size.width*0.05,
            right: MediaQuery.of(context).size.width*0.05,
            child: SingleChildScrollView(
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  children: [
                    Avatar(
                      avatarURL: avatarURL,
                    ),
                    SizedBox(height: 20),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  'Name Loading...',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: KERed,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                ));
                          }
                          Map<String, dynamic> data = snapshot.data.data();
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "${data['last name']} " + "${data['first name']}",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: KERed,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                    SizedBox(height: 20),
                    Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: KELightYellow,
                      ),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Loading, please wait");
                          }
                          Map<String, dynamic> data = snapshot.data.data();
                          return Column(
                            children: [
                              Expanded(
                                  child: buildTextField(
                                      'Email',
                                      '${data['email']}',
                                      false,
                                      KERed,
                                      emailController,
                                      'Email')),
                              Expanded(
                                  child: buildTextField(
                                      'Room',
                                      '${data['room']}',
                                      true,
                                      KEBlack,
                                      roomController,
                                      'Room')),
                              Expanded(
                                  child: buildTextField(
                                      'First Name',
                                      '${data['first name']}',
                                      true,
                                      KEBlack,
                                      firstNameController,
                                      'First Name')),
                              Expanded(
                                  child: buildTextField(
                                      'Last Name',
                                      '${data['last name']}',
                                      true,
                                      KEBlack,
                                      lastNameController,
                                      'Last Name')),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      key: Key('Edit Account Button'),
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: KELightRed,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: KERed),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => editAccount()));
                      }, //TODO
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      key: Key('Manage Bookings Button'),
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: KELightRed,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Manage My Bookings",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: KERed),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageBookingsPage()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  Widget buildTextField(String labelText, String placeHolder, bool isEditable,
      Color textColor, TextEditingController controller, String fieldName) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.5),
      child: TextFormField(
        controller: controller,
        enabled: isEditable ? true : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w700, color: KERed),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: KERed),
        ),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              controller..text = placeHolder;
            });
          }
        },
      ),
    );
  }
  downloadURLExample() async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('images/profilePic/${user.uid}')
        .getDownloadURL();
    setState(() {
      avatarURL = downloadURL;
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class pathPainter extends CustomPainter {
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
    return true;
  }
}
