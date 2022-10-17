import 'package:flutter/material.dart';
import 'package:hire_app/Dashboard.dart';
import 'package:hire_app/Login.dart';
import 'package:hire_app/SignIn.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({Key? key}) : super(key: key);

  @override
  _SliderScreenState createState() => _SliderScreenState();
}

Future<void> _incrementCounter1() async {

  SharedPreferences.getInstance().then(
        (prefs) {
      //prefs.setBool("is_logged_in", true);
      token= prefs.getString("token")!;

    },
  );
}

class _SliderScreenState extends State<SliderScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    _incrementCounter1();

  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _currentIndex = 0;
    return Scaffold(
        backgroundColor: Colors.white70,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 2.5 * (size.height / 3),
                decoration: new BoxDecoration(
                    //borderRadius: BorderRadius.only(bottomRight: Radius.circular(100),bottomLeft: Radius.circular(100)),
                    image: new DecorationImage(
                  image: new AssetImage("images/gradient.png"),
                  fit: BoxFit.cover,
                  //color: Colors.white
                )),
                child: Column(
                  children: [
                    Container(
                      height: size.height / 5,
                      child: Image(
                        image: AssetImage("images/kobl_logo.png"),
                      ),
                    ),
                    Container(
                      height: 2 * (size.height / 5),
                      width: size.width,
                      child: Image(
                        image: AssetImage("images/Introscreen.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                    color: Colors.white),
                height:(size.height /2.3),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,top: 20),
                        child: Text("How we are",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                        child: Text("Helping Employers",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.blue),),
                      ),

                      CarouselSlider(
                        items: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pre-Screened Candidates",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.orangeAccent)),
                              Text("Find developers to hire, pick any language skill to search & view PRE-SCREENED profiles making tech hiring faster, more accurate and less expensive.",
                                style: TextStyle(fontSize: 18 ),)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Live Coding Videos",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.orangeAccent)),
                              Text("Resumes aren't enough. Use Kobl's data-backed assessment to identify skilled applicants before wasting time in tech screens.",
                                style: TextStyle(fontSize: 18 ),)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Psychometric Assessment",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.orangeAccent)),
                              Text("Save time by making the feedback process as efficient as feasible. To keep you aligned with your company's needs, the tool includes skill-based scorecards and integrated interview prompts.",
                                style: TextStyle(fontSize: 18 ),)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Trustworthy Interview Panel",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.orangeAccent)),
                              Text("Experts from a variety of technical domains from across the globe that provide unbiased, trustworthy assessments. Candidates certified by these professionals are productive from day one.",
                                style: TextStyle(fontSize: 18 ),)
                            ],
                          )
                        ],
                        //Slider Container properties
                        options: CarouselOptions(
                          aspectRatio: 2.3,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(
                                  () {
                                _currentIndex = index;
                              },
                            );
                          },
                        ),

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            //height: 50,
                            padding: EdgeInsets.only( right: 20),
                            child: RaisedButton(
                              onPressed: () async {



                                if(token=="")
                                  Navigator.pushReplacement(
                                    context, MaterialPageRoute(
                                    builder: (context) => SignIn()));

                                if(token!="")
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(
                                      builder: (context) => Dashboard()));


                              },
                              child: Text('Get Started',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontFamily: "Candara")),
                              color: Colors.orangeAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
