import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hire_app/Register.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor:Color.fromARGB(244,244, 239, 235),
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
                          image: AssetImage("images/OTP.png"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "OTP Verification",
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("You have recieved an OTP ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent)),
                      Text("on your registered Mobile No.",
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
                          OtpTextField(
                            numberOfFields: 6,
                            borderWidth: 0,
                            borderColor: Colors.grey,
                            filled: true,
                            fillColor: Colors.black26,
                            focusedBorderColor: Colors.deepOrange,
                            obscureText: true,
                            showFieldAsBox: true,
                            onCodeChanged: (String code) {
                            },
                            onSubmit: (String verificationCode){
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      title: Text("Verification Code"),
                                      content: Text('Code entered is $verificationCode'),
                                    );
                                  }
                              );
                            }, // end onSubmit
                          ),
                          SizedBox(height: 50),
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 40, right: 40),
                            child: RaisedButton(
                              onPressed: () async {},
                              child: Text('Verify',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
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
                            child: Column(
                              children: [
                                //Text("Didn't Forget Password?",style: TextStyle(fontSize: 18),),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => Register()));
                                  },
                                    child: Text("<< Go Back",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.deepOrange))),
                              ],
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
