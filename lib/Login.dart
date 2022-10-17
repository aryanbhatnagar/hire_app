import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hire_app/Candidate.dart';
import 'package:hire_app/Dashboard.dart';
import 'package:hire_app/ForgotPassword.dart';
import 'package:hire_app/Register.dart';
import 'package:hire_app/SeeAll.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'globals.dart';
late login? _log =null;
late int login_code=0;
login loginFromJson(String str) => login.fromJson(json.decode(str));
String loginToJson(login data) => json.encode(data.toJson());
class login {
  login({
    required this.success,
  });

  Success success;

  factory login.fromJson(Map<String, dynamic> json) => login(
    success: Success.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success.toJson(),
  };
}
class Success {
  Success({
    required this.token,
  });

  String token;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
Future<void> _incrementCounter(int role) async {

  SharedPreferences.getInstance().then(
        (prefs) {
      prefs.setBool("is_logged_in", true);
      prefs.setString("token", token);

    },
  );
}


Future<login> loginapi (String email, String pass) async {
  final String apiUrl =
      "${BASE}api/login";
  final response = await http.post(Uri.parse(apiUrl),
      body: {
        "email":email,
        "password":pass
  });

  if (response.statusCode == 200) {
    login_code=200;
    print("login successful");
    final String responseString = response.body;
    debugPrint(response.body);
    return loginFromJson(responseString);
  }
  if(response.statusCode == 401) {
    login_code=401;
    login b=new  login(success: Success(token: ""));
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late String _email,_password;
  bool load=false;

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
                  height: size.height / 2.05,
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
                          image: AssetImage("images/Login.png"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome!!",
                        style: TextStyle(fontSize: 25),
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
                SizedBox(height: 50,),

                Container(
                  child: Form(
                    key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Center(
                            child: Visibility(
                                visible: load,
                                child: CircularProgressIndicator()),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 40, right: 40),
                            child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) return 'Enter Mobile or E-mail';
                              },
                              controller: emailController,
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
                                labelText: 'E-mail or Mobile no.',
                                labelStyle: TextStyle(fontFamily: "Candara",color: Colors.grey),
                                prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                fillColor: Colors.grey,
                                focusColor: Colors.orangeAccent,
                              ),
                              // onSaved: (input) => _name = input!
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.only(left: 40, right: 40),
                            child: TextFormField(
                              validator: (input) {
                                if (input!.length < 6)
                                  return 'Provide Minimum 6 Characters';
                              },
                              controller: passwordController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.orangeAccent, width: 2.0),
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Password',
                                labelStyle: TextStyle(fontFamily: "Candara",color: Colors.grey),
                                prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                                fillColor: Colors.grey,
                                focusColor: Colors.orangeAccent,
                              ),
                              obscureText: true,
                              //padding: EdgeInsets.fromLTRB(20,20,20,20),
                              //onSaved:  (input) => _password = input!
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 40,right: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => ForgotPass()));
                                  },
                                  child: Text("Forgot Password?",style: TextStyle(fontSize: 16,color: Colors.orangeAccent,fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 40, right: 40),
                            child: RaisedButton(
                              onPressed: () async {

                                if(_formKey.currentState!.validate())
                                  {
                                   setState(() {
                                     load=!load;
                                   });
                                _email=emailController.text;
                                _password=passwordController.text;
                               /*showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    content:  Row(
                                      children: [
                                        CircularProgressIndicator(),
                                        Text('  Processing...'),
                                      ],
                                    ),
                                    actions: <Widget>[
                                    ],
                                  ),
                                );*/
                                login log = await loginapi(_email, _password);
                                   setState(() {
                                     _log=log;
                                   });

                                if(login_code==200) {
                                  setState(() {

                                    token = _log!.success.token;
                                  });
                                  debugPrint(token.toString());
                                  debugPrint("loginnnn");
                                  await _incrementCounter(1);
                                  //Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) => Dashboard()));
                                  }

                                if(login_code==401){
                                  //Navigator.pop(context);
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Unauthorized Login"),
                                      content: const Text('Invalid Login Credentials'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () => Navigator.pop(context, 'OK'),
                                            child: const Text('OK',style: TextStyle(color: Colors.teal))
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                  }

                              },
                              child: Text('Login',
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
                                    builder: (context) => Register()));
                              },
                              child: Column(
                                children: [
                                  Text("Don't have an account?",style: TextStyle(fontSize: 18),),
                                  Text("Register Here",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.deepOrange)),
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
