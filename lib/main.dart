import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_app/Candidate.dart';
import 'package:hire_app/CategoryList.dart';
import 'package:hire_app/Dashboard.dart';
import 'package:hire_app/ForgotPassword.dart';
import 'package:hire_app/Login.dart';
import 'package:hire_app/OTP.dart';
import 'package:hire_app/Register.dart';
import 'package:hire_app/SignIn.dart';
import 'package:hire_app/Slider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyApp1()
    );
  }
}

class MyApp1 extends StatefulWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {

  int _counter = 0;

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        theme: ThemeData(
          primaryColor: Colors.teal,
        ),
        home: SliderScreen
          (),
        routes: <String,WidgetBuilder>{
          "slider":(BuildContext context)=>SignIn(),


        }
    );
  }
}
