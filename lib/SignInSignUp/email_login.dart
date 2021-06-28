import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keviiapp/SignInSignUp/email_signup.dart';
import 'package:keviiapp/colorScheme.dart';
import '../HomePage/home.dart';
import 'package:keviiapp/Auth.dart';

class EmailLogIn extends StatefulWidget {
  final FirebaseAuth auth;
  const EmailLogIn({
    Key key,
    @required this.auth,
  }) : super(key: key);

  @override
  _EmailLogInState createState() => _EmailLogInState();
}

class _EmailLogInState extends State<EmailLogIn> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CustomPaint(
                      painter: pathPainter(),
                    ),
                  ),
                  Positioned(
                    top:0,
                    child: Container(
                      height: 307,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Image.asset(
                          'assets/image/KEVIILogo.png', fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.45,
                    child: Container(
                      padding: EdgeInsets.all(50.0),
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: KERed,
                              fontFamily: 'Montserrat',
                              fontSize: 35.0,
                              fontWeight: FontWeight.w900,
                            ),
                          )),
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width * 0.8,
                    bottom: MediaQuery.of(context).size.height * 0.4,
                    left: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
                      key: Key('Email Field'),
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: KELightYellow,
                        prefixIcon: Icon(
                          Icons.email,
                          color: KERed,
                        ),
                        hintText: "Enter NUS Email",
                        hintStyle:
                        TextStyle(color: KERed, fontFamily: 'Montserrat'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Email Address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width * 0.8,
                    bottom: MediaQuery.of(context).size.height * 0.3,
                    left: MediaQuery.of(context).size.width * 0.1,
                    child: TextFormField(
                      key: Key('Password Field'),
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: KELightYellow,
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: KERed,
                        ),
                        hintText: "Enter Password",
                        hintStyle:
                        TextStyle(color: KERed, fontFamily: 'Montserrat'),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Password';
                        } else if (value.length < 6) {
                          return 'Password must be atleast 6 characters!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.22,
                    child: isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide.none,
                          )),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(KERed)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          String userResult = await Auth(auth: FirebaseAuth.instance).signIn(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          if (userResult =='Success') {
                            emailController.clear();
                            passwordController.clear();
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Home(uid: auth.currentUser.uid)));
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            print(userResult);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: KELightYellow,
                                    title: Text("Error", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: KERed),),
                                    content: Text(userResult, style: TextStyle(fontSize: 18, color: KERed), textAlign: TextAlign.left,),
                                    actions: [
                                      ElevatedButton(
                                        style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(
                                            KERed)),
                                        child: Text("Retry", style: TextStyle(fontSize: 18, color: KELightYellow, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(
                            color: KELightYellow, fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.15,
                    child: GestureDetector(
                      key: Key('Sign Up Link'),
                        child: Text("New KEViian? Sign Up Here",
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                                decoration: TextDecoration.underline,
                                color: KERed)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EmailSignUp()),
                          );
                        }),
                  ),
                ]))));
  }

  void logInToFb() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
      );
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: KELightYellow,
              title: Text("Error", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: KERed),),
              content: Text(err.message, style: TextStyle(fontSize: 18, color: KERed), textAlign: TextAlign.left,),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(
                      KERed)),
                  child: Text("Retry", style: TextStyle(fontSize: 18, color: KELightYellow, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = KELightRed;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.40,
        size.width * 0.58, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.72, size.height * 0.8,
        size.width * 0.92, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.8, size.width, size.height * 0.82);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}