import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_app/Candidate.dart';
import 'package:hire_app/Dashboard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';

Marketplace marketplaceFromJson(String str) => Marketplace.fromJson(json.decode(str));
String marketplaceToJson(Marketplace data) => json.encode(data.toJson());

class Marketplace {
  Marketplace({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory Marketplace.fromJson(Map<String, dynamic> json) => Marketplace(
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
    required this.candidates,
  });

  List<FullProfile> candidates;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    candidates: List<FullProfile>.from(json["candidates"].map((x) => FullProfile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
  };
}

Future<Marketplace> getmarket(String tech) async {
  final String apiUrl =
      "${BASE}api/candidate/marketplace";
  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body: {"tech":tech});

  if (response.statusCode == 200) {
    print("Catlist fetched");
    final String responseString = response.body;
    debugPrint(response.body);
    return marketplaceFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

String _dropDownValueNot = "";
String _dropDownValueNot1 = "";
String _dropDownValuectc = "";
String _dropDownValueexp = "";

class CatList extends StatefulWidget {
  //const CatList({Key? key}) : super(key: key);
  var techName;
  var techtype;
  var techimg;

  CatList(this.techName, this.techtype,this.techimg);

  @override
  _CatListState createState() => _CatListState(techName,techtype, techimg);
}

class _CatListState extends State<CatList> {

  var techName;
  var techtype;
  var techimg;

  _CatListState(this.techName,this.techtype, this.techimg);

  List<bool> isSelected =List.generate(4, (index) => false);
  List<bool> isSelected1 =List.generate(3, (index) => false);
  List<String> Notice=[];
  List<String> Ctc=[];

  List<String> Exp=[];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Color.fromARGB(244,244, 239, 235),
      body: FutureBuilder(
          future: getmarket(techName.toString()),
          builder: (context,AsyncSnapshot<Marketplace> snapshot) {
            print(snapshot.data);
            if (snapshot.hasData)
            {
              if(Notice.isEmpty) {
                for (var i = 0; i <
                    snapshot.data!.data.candidates.length; i++) {
                  String not = snapshot.data!.data.candidates[i].notice.toString();
                  String ct = snapshot.data!.data.candidates[i].ctc.toString();
                  String ex = snapshot.data!.data.candidates[i].exp.toString();


                  if(!Notice.contains("${not} days") && not!="0")
                    Notice.add("${not} days");
                  if(!Notice.contains("Immediate") && not=="0")
                    Notice.add("Immediate");
                  if(!Ctc.contains("${ct} LPA"))
                    Ctc.add("${ct} LPA");
                  if(!Exp.contains("${ex} yrs") && ex!="1")
                    Exp.add("${ex} yrs");
                  if(!Exp.contains("${ex} yr") && ex=="1")
                    Exp.add("${ex} yr");

                }
              }
              return SafeArea(
                child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("images/gradient1.png"),
                          fit: BoxFit.cover,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            children: [

                              //TopContainer
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: size.height/5,
                                width: size.width-30,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.purple.shade200,

                                        Colors.orange.shade200,
                                        Colors.purple.shade200,

                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(40)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20,top: 20),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                              onTap: (){

                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                    builder: (context) => Dashboard()));
                                              },
                                              child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,))
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image(image: NetworkImage("${BASE}${techimg}"),height: 60,width: 60,),
                                        SizedBox(width: 20,),
                                        Text("${techName.toString().toUpperCase()}  ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                                        Card(
                                          color: Colors.blue.shade700,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            child: Text("${techtype.toString().toUpperCase()}",style: TextStyle(color: Colors.white,fontSize: 12),),
                                          ),
                                        ),
                                      ],
                                    ),
                                   SizedBox(height: 15,),

                                    SizedBox(height: 10,),
                                    Text("${snapshot.data!.data.candidates.length} candidates available",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),

                              //Dropdowns
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      String _currentSelectedValue='';
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Container(
                                          height: 55,
                                          width: size.width/3.7,
                                          //padding: EdgeInsets.only(left: 10,right: 10),
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              //labelText: 'CLASS',
                                              //hintText: "Notice",
                                                labelStyle: TextStyle(fontFamily: "Candara"),
                                                errorStyle: TextStyle(fontFamily:"Candara",color: Colors.redAccent, fontSize: 16.0),
                                                //hintText: 'Please select expense',,
                                                enabledBorder:OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                                    borderRadius: BorderRadius.circular(10)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.teal,width: 2.0),
                                                    borderRadius: BorderRadius.circular(10)
                                                )),
                                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                            isEmpty: _currentSelectedValue == '',
                                            child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  menuMaxHeight: 200,
                                                  hint: _dropDownValueNot == ""
                                                      ? Text('Notice')
                                                      : Text(
                                                    _dropDownValueNot,
                                                    style: TextStyle(fontFamily: "Candara",color: Colors.black,fontSize: 14),
                                                  ),
                                                  isExpanded: false,
                                                  iconSize: 20,
                                                  style: TextStyle(color: Colors.black),
                                                  items: Notice.map(
                                                        (val) {
                                                      return DropdownMenuItem<String>(
                                                        value: val,
                                                        child: Text(val),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? val) {

                                                    _dropDownValueNot = val!;
                                                    _dropDownValueNot1= val!;
                                                    if(val=="Immediate")
                                                      _dropDownValueNot1="0 days";

                                                    (context as Element).markNeedsBuild();

                                                  },
                                                )
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      String _currentSelectedValue='';
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Container(
                                          height: 55,
                                          width: size.width/3.7,
                                          //padding: EdgeInsets.only(left: 10,right: 10),
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              //labelText: 'CLASS',
                                              //hintText: "CTC",
                                                labelStyle: TextStyle(fontFamily: "Candara"),
                                                errorStyle: TextStyle(fontFamily:"Candara",color: Colors.redAccent, fontSize: 16.0),
                                                //hintText: 'Please select expense',,
                                                enabledBorder:OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                                    borderRadius: BorderRadius.circular(10)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.teal,width: 2.0),
                                                    borderRadius: BorderRadius.circular(10)
                                                )),
                                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                            isEmpty: _currentSelectedValue == '',
                                            child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  menuMaxHeight: 200,
                                                  hint: _dropDownValuectc == ""
                                                      ? Text('CTC')
                                                      : Text(
                                                    _dropDownValuectc,
                                                    style: TextStyle(fontFamily: "Candara",color: Colors.black,fontSize: 16),
                                                  ),
                                                  isExpanded: false,
                                                  iconSize: 20,
                                                  style: TextStyle(color: Colors.black),
                                                  items: Ctc.map(
                                                        (val) {
                                                      return DropdownMenuItem<String>(
                                                        value: val,
                                                        child: Text(val),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? val) {
                                                    _dropDownValuectc = val!;
                                                    (context as Element).markNeedsBuild();

                                                  },
                                                )
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      String _currentSelectedValue='';
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Container(
                                          height: 55,
                                          width: size.width/3.7,
                                          //padding: EdgeInsets.only(left: 10,right: 10),
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                              //labelText: 'CLASS',
                                              //hintText: "Exp",
                                                labelStyle: TextStyle(fontFamily: "Candara"),
                                                errorStyle: TextStyle(fontFamily:"Candara",color: Colors.redAccent, fontSize: 16.0),
                                                //hintText: 'Please select expense',,
                                                enabledBorder:OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                                                    borderRadius: BorderRadius.circular(10)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(color: Colors.teal,width: 2.0),
                                                    borderRadius: BorderRadius.circular(10)
                                                )),
                                            //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                            isEmpty: _currentSelectedValue == '',
                                            child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  menuMaxHeight: 200,
                                                  hint: _dropDownValueexp == ""
                                                      ? Text('Exp')
                                                      : Text(
                                                    _dropDownValueexp,
                                                    style: TextStyle(fontFamily: "Candara",color: Colors.black,fontSize: 16),
                                                  ),
                                                  isExpanded: false,
                                                  iconSize: 20,
                                                  style: TextStyle(color: Colors.black),
                                                  items: Exp.map(
                                                        (val) {
                                                      return DropdownMenuItem<String>(
                                                        value: val,
                                                        child: Text(val),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? val) {
                                                    _dropDownValueexp = val!;
                                                    if(val=="1 yr")
                                                      _dropDownValueexp="1 yrs";
                                                    (context as Element).markNeedsBuild();

                                                  },
                                                )
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if(_dropDownValuectc!=""||_dropDownValueNot!=""||_dropDownValueexp!="")
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _dropDownValueNot="";
                                        _dropDownValueNot1="";
                                        _dropDownValueexp="";
                                        _dropDownValuectc="";
                                      });
                                    },
                                    child: Card(
                                      color: Colors.blue.shade700,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text("Reset Filter",style: TextStyle(color: Colors.white),),
                                      ),
                                    ),
                                  )

                                ],
                              ),



                              SizedBox(height: 10,),

                              //no filter
                              if(_dropDownValueNot1==""&&_dropDownValuectc==""&&_dropDownValueexp=="")
                                for(var i=0;i<snapshot.data!.data.candidates.length;i++)
                                  GestureDetector(
                                  onTap:(){
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                        builder: (context) => Candidate(snapshot.data!.data.candidates[i].userId.toString())));

                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Center(
                                                        child: CircleAvatar(
                                                          backgroundColor: Colors.transparent,
                                                          backgroundImage: snapshot.data!.data.candidates[i].profileImage==null?
                                                          NetworkImage("http://kobl.ai/img/profile.png")
                                                              :             NetworkImage("${snapshot.data!.data.candidates[i].profileImage}"),
                                                          radius: 28,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      RatingBarIndicator(
                                                        rating: double.parse("${snapshot.data!.data.candidates[i].ratings.toString()}")/5,
                                                        itemBuilder: (context, index) => Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        itemCount: 5,
                                                        itemSize: 15,
                                                        direction: Axis.horizontal,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 20,),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${snapshot.data!.data.candidates[i].name.toString()}",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Candara',
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      SizedBox(height:2),
                                                      Text(
                                                          "${snapshot.data!.data.candidates[i].designation.toString()}",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Candara',
                                                            color: Colors.blue,
                                                            fontSize: 15,
                                                          ),
                                                          maxLines: 5,
                                                          overflow: TextOverflow.ellipsis),

                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      if(snapshot.data!.data.candidates[i].notice.toString()!="0")
                                                        Text("Notice : ${snapshot.data!.data.candidates[i].notice.toString()} days",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                      if(snapshot.data!.data.candidates[i].notice.toString()=="0")
                                                        Text("Notice : Immediate",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),

                                                      SizedBox(height: 5,),
                                                      Row(
                                                        children: [
                                                          Text("CTC : ${snapshot.data!.data.candidates[i].ctc.toString()} LPA",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                          if(snapshot.data!.data.candidates[i].exp.toString()!="1")
                                                          Text("     Exp : ${snapshot.data!.data.candidates[i].exp.toString()} yrs",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                          if(snapshot.data!.data.candidates[i].exp.toString()=="1")
                                                            Text("     Exp : ${snapshot.data!.data.candidates[i].exp.toString()} yr",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Icon(Icons.arrow_forward_ios_outlined,color: Colors.orangeAccent,size: 20,),
                                            ],
                                          ),
                                          /*Container(
                                            //height: 100,
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  childAspectRatio: 2.5,
                                                  crossAxisSpacing:3,
                                                  mainAxisSpacing: 3,
                                                  crossAxisCount: 3,
                                                  children: <Widget>[
                                                    for(var i=0;i<3;i++)
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: Card(
                                                            color: Colors.blue.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Row(
                                                                children: [
                                                                  Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text("Google",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      )


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              //notice filter
                              if(_dropDownValueNot1!=""&&_dropDownValuectc==""&&_dropDownValueexp=="")
                                for(var i=0;i<snapshot.data!.data.candidates.length;i++)
                                  if("${snapshot.data!.data.candidates[i].notice} days" == _dropDownValueNot1)
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => Candidate(snapshot.data!.data.candidates[i].userId.toString())));

                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Center(
                                                            child: CircleAvatar(
                                                              backgroundColor: Colors.transparent,
                                                              backgroundImage: snapshot.data!.data.candidates[i].profileImage==null?
                                                              NetworkImage("http://kobl.ai/img/profile.png")
                                                                  :             NetworkImage("${snapshot.data!.data.candidates[i].profileImage}"),
                                                              radius: 28,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,),
                                                          RatingBarIndicator(
                                                            rating: double.parse("${snapshot.data!.data.candidates[i].ratings.toString()}")/5,
                                                            itemBuilder: (context, index) => Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 15,
                                                            direction: Axis.horizontal,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 20,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data!.data.candidates[i].name.toString()}",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          SizedBox(height:2),
                                                          Text(
                                                              "${snapshot.data!.data.candidates[i].designation.toString()}",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.blue,
                                                                fontSize: 15,
                                                              ),
                                                              maxLines: 5,
                                                              overflow: TextOverflow.ellipsis),

                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()!="0")
                                                            Text("Notice : ${snapshot.data!.data.candidates[i].notice.toString()} days",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()=="0")
                                                            Text("Notice : Immediate",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),

                                                          SizedBox(height: 5,),
                                                          Row(
                                                            children: [
                                                              Text("CTC : ${snapshot.data!.data.candidates[i].ctc.toString()}LPA",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                              Text("     Exp : ${snapshot.data!.data.candidates[i].exp.toString()}yrs",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(Icons.arrow_forward_ios_outlined,color: Colors.orangeAccent,size: 20,),
                                                ],
                                              ),
                                              /*Container(
                                            //height: 100,
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  childAspectRatio: 2.5,
                                                  crossAxisSpacing:3,
                                                  mainAxisSpacing: 3,
                                                  crossAxisCount: 3,
                                                  children: <Widget>[
                                                    for(var i=0;i<3;i++)
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: Card(
                                                            color: Colors.blue.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Row(
                                                                children: [
                                                                  Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text("Google",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      )


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                              //ctcfilter
                              if(_dropDownValueNot1==""&&_dropDownValuectc!=""&&_dropDownValueexp=="")
                                for(var i=0;i<snapshot.data!.data.candidates.length;i++)
                                  if("${snapshot.data!.data.candidates[i].ctc} LPA" == _dropDownValuectc)
                                    GestureDetector(
                                    onTap:(){
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) => Candidate(snapshot.data!.data.candidates[i].userId.toString())));

                                    },
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Center(
                                                          child: CircleAvatar(
                                                            backgroundColor: Colors.transparent,
                                                            backgroundImage: snapshot.data!.data.candidates[i].profileImage==null?
                                                            NetworkImage("http://kobl.ai/img/profile.png")
                                                                :             NetworkImage("${snapshot.data!.data.candidates[i].profileImage}"),
                                                            radius: 28,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        RatingBarIndicator(
                                                          rating: double.parse("${snapshot.data!.data.candidates[i].ratings.toString()}")/5,
                                                          itemBuilder: (context, index) => Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          itemCount: 5,
                                                          itemSize: 15,
                                                          direction: Axis.horizontal,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(width: 20,),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "${snapshot.data!.data.candidates[i].name.toString()}",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: 'Candara',
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        SizedBox(height:2),
                                                        Text(
                                                            "${snapshot.data!.data.candidates[i].designation.toString()}",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              color: Colors.blue,
                                                              fontSize: 15,
                                                            ),
                                                            maxLines: 5,
                                                            overflow: TextOverflow.ellipsis),

                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        if(snapshot.data!.data.candidates[i].notice.toString()!="0")
                                                          Text("Notice : ${snapshot.data!.data.candidates[i].notice.toString()} days",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                        if(snapshot.data!.data.candidates[i].notice.toString()=="0")
                                                          Text("Notice : Immediate",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),

                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Text("CTC : ${snapshot.data!.data.candidates[i].ctc.toString()}LPA",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                            Text("     Exp : ${snapshot.data!.data.candidates[i].exp.toString()}yrs",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Icon(Icons.arrow_forward_ios_outlined,color: Colors.orangeAccent,size: 20,),
                                              ],
                                            ),
                                            /*Container(
                                            //height: 100,
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  childAspectRatio: 2.5,
                                                  crossAxisSpacing:3,
                                                  mainAxisSpacing: 3,
                                                  crossAxisCount: 3,
                                                  children: <Widget>[
                                                    for(var i=0;i<3;i++)
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: Card(
                                                            color: Colors.blue.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Row(
                                                                children: [
                                                                  Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text("Google",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      )


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),*/
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),


                              //expfilter
                              if(_dropDownValueNot1==""&&_dropDownValuectc==""&&_dropDownValueexp!="")
                                for(var i=0;i<snapshot.data!.data.candidates.length;i++)
                                  if("${snapshot.data!.data.candidates[i].exp} yrs" == _dropDownValueexp)
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => Candidate(snapshot.data!.data.candidates[i].userId.toString())));

                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Center(
                                                            child: CircleAvatar(
                                                              backgroundColor: Colors.transparent,
                                                              backgroundImage: snapshot.data!.data.candidates[i].profileImage==null?
                                                              NetworkImage("http://kobl.ai/img/profile.png")
                                                                  :             NetworkImage("${snapshot.data!.data.candidates[i].profileImage}"),
                                                              radius: 28,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,),
                                                          RatingBarIndicator(
                                                            rating: double.parse("${snapshot.data!.data.candidates[i].ratings.toString()}")/5,
                                                            itemBuilder: (context, index) => Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 15,
                                                            direction: Axis.horizontal,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 20,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data!.data.candidates[i].name.toString()}",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          SizedBox(height:2),
                                                          Text(
                                                              "${snapshot.data!.data.candidates[i].designation.toString()}",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.blue,
                                                                fontSize: 15,
                                                              ),
                                                              maxLines: 5,
                                                              overflow: TextOverflow.ellipsis),

                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()!="0")
                                                            Text("Notice : ${snapshot.data!.data.candidates[i].notice.toString()} days",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()=="0")
                                                            Text("Notice : Immediate",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),

                                                          SizedBox(height: 5,),
                                                          Row(
                                                            children: [
                                                              Text("CTC : ${snapshot.data!.data.candidates[i].ctc.toString()}LPA",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                              Text("     Exp : ${snapshot.data!.data.candidates[i].exp.toString()}yrs",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(Icons.arrow_forward_ios_outlined,color: Colors.orangeAccent,size: 20,),
                                                ],
                                              ),
                                              /*Container(
                                            //height: 100,
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  childAspectRatio: 2.5,
                                                  crossAxisSpacing:3,
                                                  mainAxisSpacing: 3,
                                                  crossAxisCount: 3,
                                                  children: <Widget>[
                                                    for(var i=0;i<3;i++)
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: Card(
                                                            color: Colors.blue.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Row(
                                                                children: [
                                                                  Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text("Google",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      )


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                              //not&exp
                              if(_dropDownValueNot1!=""&&_dropDownValuectc==""&&_dropDownValueexp!="")
                                for(var i=0;i<snapshot.data!.data.candidates.length;i++)
                                  if("${snapshot.data!.data.candidates[i].notice} days" == _dropDownValueNot1 &&
                                      "${snapshot.data!.data.candidates[i].exp} yrs" == _dropDownValueexp )
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => Candidate(snapshot.data!.data.candidates[i].userId.toString())));

                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Center(
                                                            child: CircleAvatar(
                                                              backgroundColor: Colors.transparent,
                                                              backgroundImage: snapshot.data!.data.candidates[i].profileImage==null?
                                                              NetworkImage("http://kobl.ai/img/profile.png")
                                                                  :             NetworkImage("${snapshot.data!.data.candidates[i].profileImage}"),
                                                              radius: 28,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,),
                                                          RatingBarIndicator(
                                                            rating: double.parse("${snapshot.data!.data.candidates[i].ratings.toString()}")/5,
                                                            itemBuilder: (context, index) => Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 15,
                                                            direction: Axis.horizontal,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 20,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data!.data.candidates[i].name.toString()}",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          SizedBox(height:2),
                                                          Text(
                                                              "${snapshot.data!.data.candidates[i].designation.toString()}",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.blue,
                                                                fontSize: 15,
                                                              ),
                                                              maxLines: 5,
                                                              overflow: TextOverflow.ellipsis),

                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()!="0")
                                                            Text("Notice : ${snapshot.data!.data.candidates[i].notice.toString()} days",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()=="0")
                                                            Text("Notice : Immediate",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),

                                                          SizedBox(height: 5,),
                                                          Row(
                                                            children: [
                                                              Text("CTC : ${snapshot.data!.data.candidates[i].ctc.toString()}LPA",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                              Text("     Exp : ${snapshot.data!.data.candidates[i].exp.toString()}yrs",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(Icons.arrow_forward_ios_outlined,color: Colors.orangeAccent,size: 20,),
                                                ],
                                              ),
                                              /*Container(
                                            //height: 100,
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  childAspectRatio: 2.5,
                                                  crossAxisSpacing:3,
                                                  mainAxisSpacing: 3,
                                                  crossAxisCount: 3,
                                                  children: <Widget>[
                                                    for(var i=0;i<3;i++)
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: Card(
                                                            color: Colors.blue.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Row(
                                                                children: [
                                                                  Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text("Google",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      )


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                              //not&ctc
                              if(_dropDownValueNot1!=""&&_dropDownValuectc!=""&&_dropDownValueexp=="")
                                for(var i=0;i<snapshot.data!.data.candidates.length;i++)
                                  if("${snapshot.data!.data.candidates[i].notice} days" == _dropDownValueNot1 &&
                                      "${snapshot.data!.data.candidates[i].ctc} LPA" == _dropDownValuectc )
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => Candidate(snapshot.data!.data.candidates[i].userId.toString())));

                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Center(
                                                            child: CircleAvatar(
                                                              backgroundColor: Colors.transparent,
                                                              backgroundImage: snapshot.data!.data.candidates[i].profileImage==null?
                                                              NetworkImage("http://kobl.ai/img/profile.png")
                                                                  :             NetworkImage("${snapshot.data!.data.candidates[i].profileImage}"),
                                                              radius: 28,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,),
                                                          RatingBarIndicator(
                                                            rating: double.parse("${snapshot.data!.data.candidates[i].ratings.toString()}")/5,
                                                            itemBuilder: (context, index) => Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 15,
                                                            direction: Axis.horizontal,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 20,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data!.data.candidates[i].name.toString()}",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          SizedBox(height:2),
                                                          Text(
                                                              "${snapshot.data!.data.candidates[i].designation.toString()}",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.blue,
                                                                fontSize: 15,
                                                              ),
                                                              maxLines: 5,
                                                              overflow: TextOverflow.ellipsis),

                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()!="0")
                                                            Text("Notice : ${snapshot.data!.data.candidates[i].notice.toString()} days",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()=="0")
                                                            Text("Notice : Immediate",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),

                                                          SizedBox(height: 5,),
                                                          Row(
                                                            children: [
                                                              Text("CTC : ${snapshot.data!.data.candidates[i].ctc.toString()}LPA",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                              Text("     Exp : ${snapshot.data!.data.candidates[i].exp.toString()}yrs",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(Icons.arrow_forward_ios_outlined,color: Colors.orangeAccent,size: 20,),
                                                ],
                                              ),
                                              /*Container(
                                            //height: 100,
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  childAspectRatio: 2.5,
                                                  crossAxisSpacing:3,
                                                  mainAxisSpacing: 3,
                                                  crossAxisCount: 3,
                                                  children: <Widget>[
                                                    for(var i=0;i<3;i++)
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: Card(
                                                            color: Colors.blue.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Row(
                                                                children: [
                                                                  Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text("Google",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      )


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),


                              //CTC&EXP
                              if(_dropDownValueNot1==""&&_dropDownValuectc!=""&&_dropDownValueexp!="")
                                for(var i=0;i<snapshot.data!.data.candidates.length;i++)
                                  if("${snapshot.data!.data.candidates[i].exp} yrs" == _dropDownValueexp &&
                                      "${snapshot.data!.data.candidates[i].ctc} LPA" == _dropDownValuectc )
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => Candidate(snapshot.data!.data.candidates[i].userId.toString())));

                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Center(
                                                            child: CircleAvatar(
                                                              backgroundColor: Colors.transparent,
                                                              backgroundImage: snapshot.data!.data.candidates[i].profileImage==null?
                                                              NetworkImage("http://kobl.ai/img/profile.png")
                                                                  :             NetworkImage("${snapshot.data!.data.candidates[i].profileImage}"),
                                                              radius: 28,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,),
                                                          RatingBarIndicator(
                                                            rating: double.parse("${snapshot.data!.data.candidates[i].ratings.toString()}")/5,
                                                            itemBuilder: (context, index) => Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 15,
                                                            direction: Axis.horizontal,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 20,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data!.data.candidates[i].name.toString()}",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          SizedBox(height:2),
                                                          Text(
                                                              "${snapshot.data!.data.candidates[i].designation.toString()}",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.blue,
                                                                fontSize: 15,
                                                              ),
                                                              maxLines: 5,
                                                              overflow: TextOverflow.ellipsis),

                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()!="0")
                                                            Text("Notice : ${snapshot.data!.data.candidates[i].notice.toString()} days",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()=="0")
                                                            Text("Notice : Immediate",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),

                                                          SizedBox(height: 5,),
                                                          Row(
                                                            children: [
                                                              Text("CTC : ${snapshot.data!.data.candidates[i].ctc.toString()}LPA",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                              Text("     Exp : ${snapshot.data!.data.candidates[i].exp.toString()}yrs",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(Icons.arrow_forward_ios_outlined,color: Colors.orangeAccent,size: 20,),
                                                ],
                                              ),
                                              /*Container(
                                            //height: 100,
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  childAspectRatio: 2.5,
                                                  crossAxisSpacing:3,
                                                  mainAxisSpacing: 3,
                                                  crossAxisCount: 3,
                                                  children: <Widget>[
                                                    for(var i=0;i<3;i++)
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: Card(
                                                            color: Colors.blue.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Row(
                                                                children: [
                                                                  Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text("Google",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      )


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                              //all filter
                              if(_dropDownValueNot1!=""&&_dropDownValuectc!=""&&_dropDownValueexp!="")
                                for(var i=0;i<snapshot.data!.data.candidates.length;i++)
                                  if("${snapshot.data!.data.candidates[i].notice} days" == _dropDownValueNot1 &&
                                      "${snapshot.data!.data.candidates[i].ctc} LPA" == _dropDownValuectc &&
                                      "${snapshot.data!.data.candidates[i].exp} yrs" == _dropDownValueexp)
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => Candidate(snapshot.data!.data.candidates[i].userId.toString())));

                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Center(
                                                            child: CircleAvatar(
                                                              backgroundColor: Colors.transparent,
                                                              backgroundImage: snapshot.data!.data.candidates[i].profileImage==null?
                                                              NetworkImage("http://kobl.ai/img/profile.png")
                                                                  :             NetworkImage("${snapshot.data!.data.candidates[i].profileImage}"),
                                                              radius: 28,
                                                            ),
                                                          ),
                                                          SizedBox(height: 5,),
                                                          RatingBarIndicator(
                                                            rating: double.parse("${snapshot.data!.data.candidates[i].ratings.toString()}")/5,
                                                            itemBuilder: (context, index) => Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 15,
                                                            direction: Axis.horizontal,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 20,),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${snapshot.data!.data.candidates[i].name.toString()}",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                          SizedBox(height:2),
                                                          Text(
                                                              "${snapshot.data!.data.candidates[i].designation.toString()}",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.blue,
                                                                fontSize: 15,
                                                              ),
                                                              maxLines: 5,
                                                              overflow: TextOverflow.ellipsis),

                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()!="0")
                                                            Text("Notice : ${snapshot.data!.data.candidates[i].notice.toString()} days",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                          if(snapshot.data!.data.candidates[i].notice.toString()=="0")
                                                            Text("Notice : Immediate",style: TextStyle(fontFamily: "Candara",fontSize: 14,),overflow: TextOverflow.ellipsis,maxLines: 2),

                                                          SizedBox(height: 5,),
                                                          Row(
                                                            children: [
                                                              Text("CTC : ${snapshot.data!.data.candidates[i].ctc.toString()}LPA",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                              Text("     Exp : ${snapshot.data!.data.candidates[i].exp.toString()}yrs",style: TextStyle(fontFamily: "Candara",fontSize: 14),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Icon(Icons.arrow_forward_ios_outlined,color: Colors.orangeAccent,size: 20,),
                                                ],
                                              ),
                                              /*Container(
                                            //height: 100,
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GridView.count(
                                                  shrinkWrap: true,
                                                  childAspectRatio: 2.5,
                                                  crossAxisSpacing:3,
                                                  mainAxisSpacing: 3,
                                                  crossAxisCount: 3,
                                                  children: <Widget>[
                                                    for(var i=0;i<3;i++)
                                                      GestureDetector(
                                                          onTap: () {
                                                          },
                                                          child: Card(
                                                            color: Colors.blue.shade200,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(5.0),
                                                              child: Row(
                                                                children: [
                                                                  Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                                  SizedBox(width: 5,),
                                                                  Text("Google",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                      )


                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                              SizedBox(height: 10,),

                              SizedBox(
                                height: 30,
                              )




                            ],
                          ),
                        ),
                      ),
                    )),
              );
            }
            else
              return Center(child: Container(child: CircularProgressIndicator(color: Colors.deepOrange,)));
          }
      ),
    );
  }
}
