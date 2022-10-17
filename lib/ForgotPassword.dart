import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hire_app/Login.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromARGB(244,244, 239, 235),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            decoration: new BoxDecoration(
              //borderRadius: BorderRadius.only(bottomRight: Radius.circular(100),bottomLeft: Radius.circular(100)),
                image: new DecorationImage(
                  image: new AssetImage("images/gradient1.png"),
                  fit: BoxFit.cover,
                  //color: Colors.white
                )),
            child: Column(
              children: <Widget>[
                Container(
                  height: size.height / 1.95,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(120),
                          bottomLeft: Radius.circular(200)),
                      color: Colors.white,
                      image: new DecorationImage(
                        image: new AssetImage("images/gradient1.png"),
                        fit: BoxFit.cover,
                        //color: Colors.white
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image(
                          //width: size.width,
                          image: AssetImage("images/ForgotPass.png"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Forgot Password",
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Start Direct conversation ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent)),
                      Text("with PRE-SCREENED candidates",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent)),

                    ],
                  ),
                ),
                SizedBox(height: 60,),
                Container(
                  child: Form(
                    //key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 40, right: 40),
                            child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) return 'Enter Mobile or E-mail';
                              },
                              //controller: nameController,
                              decoration: InputDecoration(
                                //fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.orangeAccent, width: 2.0),
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Enter registered E-mail or Mobile no.',
                                labelStyle: TextStyle(fontFamily: "Candara",color: Colors.grey),
                                prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                fillColor: Colors.grey,
                                focusColor: Colors.orangeAccent,
                              ),
                              // onSaved: (input) => _name = input!
                            ),
                          ),
                          SizedBox(height: 50),
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 40, right: 40),
                            child: RaisedButton(
                              onPressed: () async {},
                              child: Text('Recover Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontFamily: "Candara")),
                              color: Colors.orangeAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => Login()));
                              },
                              child: Column(
                                children: [
                                  Text("Didn't Forget Password?",style: TextStyle(fontSize: 18),),
                                  Text("Login here",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.deepOrange)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
