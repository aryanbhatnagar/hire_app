import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hire_app/Login.dart';
import 'package:hire_app/OTP.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';

late int register_code=0;
register registerFromJson(String str) => register.fromJson(json.decode(str));
String registerToJson(register data) => json.encode(data.toJson());
class register {
  register({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  var message;

  factory register.fromJson(Map<String, dynamic> json) => register(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}
class Data {
  Data({
    required this.token,
    this.name,
  });

  String token;
  var name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
  };
}


Future<register> registerapi (String email, String pass,String name) async {
  final String apiUrl =
      "${BASE}api/register";
  final response = await http.post(Uri.parse(apiUrl),
      body: {
    "name":name,
        "email":email,
        "password":pass
      });

  if (response.statusCode == 200) {
    register_code=200;
    print("login successful");
    final String responseString = response.body;
    debugPrint(response.body);
    return registerFromJson(responseString);
  }
  else {
    register_code=401;
    register b=new  register(success: false, data: Data(token: ""), message: "message");
    return b;
  }

}


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  late String _email,_password,_name;
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
            child: SingleChildScrollView(
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
                            width: size.width,
                            image: AssetImage("images/Register.png"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome to KOBL",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Join KOBL to accelerate your hiring",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurpleAccent)),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    child: Form(
                        key: _formKey,
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Visibility(
                                visible: load,
                                child: CircularProgressIndicator()),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter E-mail';
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
                              prefixIcon: Icon(Icons.mail_outline, color: Colors.grey),
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
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(left: 40, right: 40),
                          child: TextFormField(
                            validator: (input) {
                              if (input!.isEmpty)
                                return 'Enter Name';
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.orangeAccent, width: 2.0),
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: 'Enter Name',
                              labelStyle: TextStyle(fontFamily: "Candara",color: Colors.grey),
                              prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                              fillColor: Colors.grey,
                              focusColor: Colors.orangeAccent,
                            ),
                            obscureText: true,
                            //padding: EdgeInsets.fromLTRB(20,20,20,20),
                            //onSaved:  (input) => _password = input!
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
                                _name=nameController.text;
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
                                register log = await registerapi(_email, _password,_name);

                                if(register_code==200) {
                                  setState(() {
                                    token = log.data.token;
                                    load=!load;
                                  });
                                  debugPrint(token.toString());
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) => Login()));
                                }

                                if(register_code==401){
                                  //Navigator.pop(context);
                                  setState(() {
                                    load=!load;
                                  });
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Can't Register"),
                                      content: const Text('Email address already taken'),
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
                            child: Text('Register',
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
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              Text("Already have an account?",style: TextStyle(fontSize: 18),),
                              Text("Login Here",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.deepOrange)),
                            ],
                          ),
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
