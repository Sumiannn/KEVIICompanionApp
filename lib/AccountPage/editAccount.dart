import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/Facilities/ManageBookingsPage.dart';
import 'package:keviiapp/HomePage/home.dart';
import 'package:keviiapp/SignInSignUp/email_login.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../colorScheme.dart';
import 'avatar.dart';

class editAccount extends StatefulWidget {
  const editAccount({Key key}) : super(key: key);

  @override
  _editAccountState createState() => _editAccountState();
}

class _editAccountState extends State<editAccount> {
  _editAccountState();

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File _imageFile;
  TextEditingController emailController = TextEditingController(),
      roomController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Form(
        key: _formKey,
        child: Stack(
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
                top: MediaQuery.of(context).size.width * 0.3,
                left: MediaQuery.of(context).size.width * 0.3,
                right: MediaQuery.of(context).size.width * 0.3,
                child: Avatar(
                  onTap: () async {
                    var picker = ImagePicker();
                    final imagePicked = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      _imageFile = File(imagePicked.path);
                    });
                    uploadProfileImage(_imageFile);
                  },
                )),
            Positioned(
              top: 330,
              left: 20,
              right: 20,
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                      'Email (Not Editable)',
                                      '${data['email']}',
                                      false,
                                      KERed,
                                      emailController,
                                      'Email')),
                              Expanded(
                                  child: buildTextField(
                                      'Room (Editable)',
                                      '${data['room']}',
                                      true,
                                      KEBlack,
                                      roomController,
                                      'Room')),
                              Expanded(
                                  child: buildTextField(
                                      'First Name (Editable)',
                                      '${data['first name']}',
                                      true,
                                      KEBlack,
                                      firstNameController,
                                      'First Name')),
                              Expanded(
                                  child: buildTextField(
                                      'Last Name (Editable)',
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
                                        "Save Edit",
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
                      onTap: () async {
                        if (_formKey.currentState.validate()) {
                          updateAccount();
                        }
                        Navigator.pop(context);
                      }, //TODO
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You can only edit your Profile Picture, Room Number, First Name and Last Name. Remember to press "Save Edit" to save any changes!',
                      style: TextStyle(
                          color: KERed,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  updateAccount() async {
    print(roomController.text);
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser.uid)
        .update({
      "room": roomController.text,
      'last name': lastNameController.text,
      'first name': firstNameController.text
    });
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
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
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
            style: TextStyle(color: Colors.black),
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
              fontSize: 18, fontWeight: FontWeight.w500, color: textColor),
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
  Future<void> uploadProfileImage(File file) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('image/profilePic/${user.uid}')
          .putFile(file);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }
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
    // TODO: implement shouldRepaint
    return true;
  }
}
