import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hire_app/Register.dart';

import 'Login.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Container(
          height: size.height,
          decoration: new BoxDecoration(
              image: new DecorationImage(
            image: new AssetImage("images/gradient.png"),
            fit: BoxFit.cover,
          )),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: size.height / 2,
                  child: Center(
                    child: Image(
                      image: AssetImage("images/kobl_logo.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                  child: Card(
                    child: Container(
                      width: size.width-150,
                      child: MaterialButton(
                        //color: Colors.teal[100],
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('images/google.png'),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Sign in with Google")
                          ],
                        ),

                        // by onpressed we call the function signup function
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                  child: Card(
                    child: Container(
                      width: size.width-150,
                      child: MaterialButton(
                        //color: Colors.teal[100],
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.email),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Sign in with E-mail")
                          ],
                        ),

                        // by onpressed we call the function signup function
                        onPressed: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(
                              builder: (context) => Login()));
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                  child: Card(
                    child: Container(
                      width: size.width-150,
                      child: MaterialButton(
                        //color: Colors.teal[100],
                        elevation: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.phone),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Sign in with Phone")
                          ],
                        ),

                        // by onpressed we call the function signup function
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Text("Don't have an account?",style: TextStyle(fontSize: 18),),
                      Text("Sign Up",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.redAccent)),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ));
  }
}
