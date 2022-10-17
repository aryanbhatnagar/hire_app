import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_app/Dashboard.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';

Candidateprofile candidateprofileFromJson(String str) => Candidateprofile.fromJson(json.decode(str));
String candidateprofileToJson(Candidateprofile data) => json.encode(data.toJson());
var _c_id;
class Candidateprofile {
  Candidateprofile({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory Candidateprofile.fromJson(Map<String, dynamic> json) => Candidateprofile(
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
    required this.candidate,
    required this.educations,
    required this.employments,
    required this.feedback,
  });

  FullProfile candidate;
  List<Education> educations;
  List<Employment> employments;
  Feedback feedback;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    candidate: FullProfile.fromJson(json["candidate"]),
    educations: List<Education>.from(json["educations"].map((x) => Education.fromJson(x))),
    employments: List<Employment>.from(json["employments"].map((x) => Employment.fromJson(x))),
    feedback: Feedback.fromJson(json["feedback"]),
  );

  Map<String, dynamic> toJson() => {
    "candidate": candidate.toJson(),
    "educations": List<dynamic>.from(educations.map((x) => x.toJson())),
    "employments": List<dynamic>.from(employments.map((x) => x.toJson())),
    "feedback": feedback.toJson(),
  };
}
//candidate data mapped from full profilr class in dashboard
class Education {
  Education({
    this.id,
    this.userId,
    this.course,
    this.school,
    this.passingYear,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var userId;
  var course;
  var school;
  var passingYear;
  var createdAt;
  var updatedAt;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    id: json["id"],
    userId: json["user_id"],
    course: json["course"],
    school: json["school"],
    passingYear: json["passing_year"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "course": course,
    "school": school,
    "passing_year": passingYear,
    "created_at": createdAt,
    "updated_at": updatedAt
  };
}
class Employment {
  Employment({
    this.id,
    this.userId,
    this.companyName,
    this.designation,
    this.joiningDate,
    this.leavingDate,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var userId;
  var companyName;
  var designation;
  var joiningDate;
  var leavingDate;
  var createdAt;
  var updatedAt;

  factory Employment.fromJson(Map<String, dynamic> json) => Employment(
    id: json["id"],
    userId: json["user_id"],
    companyName: json["company_name"],
    designation: json["designation"],
    joiningDate: json["joining_date"],
    leavingDate: json["leaving_date"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "company_name": companyName,
    "designation": designation,
    "joining_date": joiningDate,
    "leaving_date": leavingDate,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
class Feedback {
  Feedback({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.conceptRating,
    this.conceptText,
    this.languageRating,
    this.languageText,
    this.understandRating,
    this.understandText,
    this.approachRating,
    this.approachText,
    this.codingRating,
    this.codingText,
    this.videoPath,
    this.date,
    this.uploadedBy,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var userId;
  var name;
  var email;
  var conceptRating;
  var conceptText;
  var languageRating;
  var languageText;
  var understandRating;
  var understandText;
  var approachRating;
  var approachText;
  var codingRating;
  var codingText;
  var videoPath;
  var date;
  var uploadedBy;
  var createdAt;
  var updatedAt;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    conceptRating: json["concept_rating"],
    conceptText: json["concept_text"],
    languageRating: json["language_rating"],
    languageText: json["language_text"],
    understandRating: json["understand_rating"],
    understandText: json["understand_text"],
    approachRating: json["approach_rating"],
    approachText: json["approach_text"],
    codingRating: json["coding_rating"],
    codingText: json["coding_text"],
    videoPath: json["video_path"],
    date: json["date"],
    uploadedBy: json["uploaded_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "email": email,
    "concept_rating": conceptRating,
    "concept_text": conceptText,
    "language_rating": languageRating,
    "language_text": languageText,
    "understand_rating": understandRating,
    "understand_text": understandText,
    "approach_rating": approachRating,
    "approach_text": approachText,
    "coding_rating": codingRating,
    "coding_text": codingText,
    "video_path": videoPath,
    "date": date,
    "uploaded_by": uploadedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

Future<Candidateprofile> getCandidateProf(String id) async {
  final String apiUrl =
      "${BASE}api/candidate/profile";
  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body: {"candidate_id":id});

  if (response.statusCode == 200) {
    print("candidate profile fetched");
    final String responseString = response.body;
    debugPrint(response.body);
    return candidateprofileFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

var _rating;

class ShortCandidate extends StatefulWidget {
  //const Candidate({Key? key}) : super(key: key);
  var c_id;

  ShortCandidate(this.c_id);

  @override
  _ShortCandidateState createState() => _ShortCandidateState(c_id);
}

class _ShortCandidateState extends State<ShortCandidate> {
  bool psyc_vis = true, int_vis = false, rev_vis = false;
  List<bool> isSelected = List.generate(3, (index) => false);
  int c = 0;
  var c_id;

  _ShortCandidateState(this.c_id);

  @override
  Widget build(BuildContext context) {
    _c_id=c_id;
    isSelected[c] = true;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:FutureBuilder(
          future: getCandidateProf(_c_id),
          builder: (context,AsyncSnapshot<Candidateprofile> snapshot) {
            print(snapshot.data);
            if (snapshot.hasData)
            {
              return Scaffold(
                backgroundColor: Colors.white,
                bottomNavigationBar: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255).withOpacity(0.5))),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: size.width / 2.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline_sharp,
                              color: Colors.orangeAccent,
                              size: 25,
                            ),
                            Text(
                              '  Interview',
                              style: TextStyle(
                                  fontFamily: 'Candara',
                                  fontSize: 20,
                                  color: Colors.orangeAccent),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        final Future<ConfirmAction4?> action =
                        await _asyncConfirmDialog4(context, "");
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 255, 255).withOpacity(0.5))),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: size.width / 2.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.person_outline_sharp,
                              color: Colors.blue[800],
                              size: 25,
                            ),
                            Text(
                              '  Hire',
                              style: TextStyle(
                                  fontFamily: 'Candara',
                                  fontSize: 20,
                                  color: Colors.blue[800]),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        final Future<ConfirmAction?> action =
                        await _asyncConfirmDialog(context, "");
                      },
                    ),
                  ],
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            height: (size.height) / 2.2,
                            width: (size.width),
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                image: DecorationImage(
                                    image: NetworkImage("${snapshot.data!.data.candidate.profileImage.toString()}"),
                                    fit: BoxFit.fill)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Status",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)),
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              "Under Interview Process",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Icon(
                                      Icons.bookmark_outline_sharp,
                                      size: 30,
                                    )
                                  ],
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Dashboard()));
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(25),
                            height: (size.height) / 2.2,
                            width: (size.width),
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                image: DecorationImage(
                                    image: AssetImage("images/pradi2.png"),
                                    fit: BoxFit.fill)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        height: (size.height) - (size.height) / 2.7,
                        width: (size.width),
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: BorderRadius.circular(34)),
                        child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                //header
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text("${snapshot.data!.data.candidate.name.toString()}",
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontFamily: "Candara",
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: 2.75,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.blue,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                    ),
                                    Text(
                                      " 3 reviews",
                                      style: TextStyle(color: Colors.grey, fontSize: 16),
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          final Future<ConfirmAction2?> action =
                                          await _asyncConfirmDialog2(context, "");
                                        },
                                        child: Text(
                                          "   Write a Review",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),

                                //availability
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text("Interview Availability",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: "Candara",
                                            color: Colors.grey)),
                                    Text("  Online",
                                        style: TextStyle(
                                            fontFamily: "Candara",
                                            fontSize: 20,
                                            color: Colors.green)),
                                  ],
                                ),
                                SizedBox(height: 5),
                                SizedBox(height: 10),
                                Text(
                                    "${snapshot.data!.data.candidate.overview.toString()}",
                                    style: TextStyle(
                                      fontFamily: "Candara",
                                      fontSize: 18,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),


                                Row(
                                  children: [
                                    Text("Designation : ",
                                        style:
                                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text("${snapshot.data!.data.candidate.designation.toString()}",
                                        style:
                                        TextStyle(fontSize: 18,)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("CTC : ",
                                        style:
                                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text("${snapshot.data!.data.candidate.ctc.toString()} LPA",
                                        style:
                                        TextStyle(fontSize: 18,)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Experience : ",
                                        style:
                                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text("${snapshot.data!.data.candidate.exp.toString()} yrs",
                                        style:
                                        TextStyle(fontSize: 18,)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Location : ",
                                        style:
                                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text("${snapshot.data!.data.candidate.loc.toString()}",
                                        style:
                                        TextStyle(fontSize: 18,)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Notice : ",
                                        style:
                                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text("${snapshot.data!.data.candidate.notice.toString()} days",
                                        style:
                                        TextStyle(fontSize: 18,)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Technology",
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  //height: 100,
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      GridView.count(
                                        shrinkWrap: true,
                                        childAspectRatio: 2.5,
                                        crossAxisSpacing: 3,
                                        mainAxisSpacing: 3,
                                        crossAxisCount: 3,
                                        children: <Widget>[
                                          for (var i = 0; i < snapshot.data!.data.candidate.skill.toString().split(",").length; i++)
                                            GestureDetector(
                                                onTap: () {},
                                                child: Card(
                                                  color: Colors.blue.shade200,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        /*Image(
                                                            image:
                                                            AssetImage("images/google.png"),
                                                            height: 15,
                                                            width: 15,
                                                          ),*/
                                                        SizedBox(
                                                          width: 0,
                                                        ),
                                                        Text(
                                                            "${snapshot.data!.data.candidate.skill.toString().split(",")[i].toUpperCase()}",
                                                            style: TextStyle(

                                                              color: Colors.white,
                                                              fontSize: 15,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Center(
                                    child: ToggleButtons(
                                      children: <Widget>[
                                        Text("  Psycometric  ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Candara",
                                            )),
                                        Text("  Int Score  ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Candara",
                                            )),
                                        Text("      Reviews     ",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Candara",
                                            )),
                                      ],
                                      selectedBorderColor: Colors.blue[800],
                                      selectedColor: Colors.white,
                                      borderColor: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                      disabledColor: Colors.transparent,
                                      disabledBorderColor: Colors.transparent,
                                      focusColor: Colors.blue[800],
                                      fillColor: Colors.blue[800],
                                      onPressed: (int index) {
                                        setState(() {

                                          for (int buttonIndex = 0;
                                          buttonIndex < isSelected.length;
                                          buttonIndex++) {
                                            if (buttonIndex == index) {
                                              isSelected[buttonIndex] = true;
                                            } else {
                                              isSelected[buttonIndex] = false;
                                            }
                                            c=index;
                                            if (index == 0) {
                                              psyc_vis = true;
                                              int_vis = false;
                                              rev_vis = false;
                                            }
                                            if (index == 1) {
                                              psyc_vis = false;
                                              int_vis = true;
                                              rev_vis = false;
                                            }
                                            if (index == 2) {
                                              psyc_vis = false;
                                              int_vis = false;
                                              rev_vis = true;
                                            }
                                          }
                                        });
                                      },
                                      isSelected: isSelected,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Visibility(
                                  visible: psyc_vis,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Personality & Ability Performance",
                                        style: TextStyle(
                                            fontSize: 22, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                                              "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                                              "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris "
                                              "nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor .",
                                          style: TextStyle(
                                            fontFamily: "Candara",
                                            fontSize: 20,
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Personality Test Performance : ",
                                              style: TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text("19%",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Ability Test Performance : ",
                                              style: TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.bold)),
                                          Text("19%",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: int_vis,
                                  child: Column(
                                    children: [
                                      //header
                                      Row(
                                        children: [
                                          Text(
                                            "Interview Score : ",
                                            style: TextStyle(
                                                fontSize: 22, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "60%",
                                            style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),

                                      //Conceptual
                                      Row(
                                        children: [
                                          Text(
                                            "Conceptual Question ",
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: RatingBarIndicator(
                                              rating: double.parse(snapshot.data!.data.feedback.conceptRating.toString()),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                              ),
                                              itemCount: 5,
                                              itemSize: 15,
                                              direction: Axis.horizontal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Card(
                                          elevation: 2,
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text("Remark"),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                        "${snapshot.data!.data.feedback.conceptText.toString()}",
                                                        style: TextStyle(
                                                          fontFamily: "Candara",
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                ],
                                              ))),

                                      //Programming
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text(
                                            "Programming Concepts ",
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: RatingBarIndicator(
                                              rating: double.parse(snapshot.data!.data.feedback.languageRating.toString()),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                              ),
                                              itemCount: 5,
                                              itemSize: 15,
                                              direction: Axis.horizontal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Card(
                                          elevation: 2,
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text("Remark"),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                        "${snapshot.data!.data.feedback.languageText.toString()}",
                                                        style: TextStyle(
                                                          fontFamily: "Candara",
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                ],
                                              ))),

                                      //TechQUES
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text(
                                            "Technical Questions ",
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: RatingBarIndicator(
                                              rating: double.parse(snapshot.data!.data.feedback.understandRating.toString()),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                              ),
                                              itemCount: 5,
                                              itemSize: 15,
                                              direction: Axis.horizontal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Card(
                                          elevation: 2,
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text("Remark"),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                        "${snapshot.data!.data.feedback.understandText.toString()}",
                                                        style: TextStyle(
                                                          fontFamily: "Candara",
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                ],
                                              ))),

                                      //APproach
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text(
                                            "Approach for problem ",
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: RatingBarIndicator(
                                              rating: double.parse(snapshot.data!.data.feedback.approachRating.toString()),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                              ),
                                              itemCount: 5,
                                              itemSize: 15,
                                              direction: Axis.horizontal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Card(
                                          elevation: 2,
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text("Remark"),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                        "${snapshot.data!.data.feedback.approachText.toString()}",
                                                        style: TextStyle(
                                                          fontFamily: "Candara",
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                ],
                                              ))),

                                      //TechCode
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Technical Code skills ",
                                            style: TextStyle(fontSize: 22),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            child: RatingBarIndicator(
                                              rating: double.parse(snapshot.data!.data.feedback.codingRating.toString()),
                                              itemBuilder: (context, index) => Icon(
                                                Icons.star,
                                                color: Colors.blue,
                                              ),
                                              itemCount: 5,
                                              itemSize: 15,
                                              direction: Axis.horizontal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Card(
                                          elevation: 2,
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: Text("Remark"),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                        "${snapshot.data!.data.feedback.codingText.toString()}",
                                                        style: TextStyle(
                                                          fontFamily: "Candara",
                                                          fontSize: 14,
                                                        )),
                                                  ),
                                                ],
                                              ))),

                                      SizedBox(
                                        height: 40,
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: rev_vis,
                                  child: Column(
                                    children: [
                                      //header
                                      Row(
                                        children: [
                                          Text(
                                            "Company Reviews ",
                                            style: TextStyle(
                                                fontSize: 22, fontWeight: FontWeight.bold),
                                          ),
                                          //Text("60%",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.green),),
                                        ],
                                      ),
                                      SizedBox(height: 20),

                                      for (var i = 0; i < 4; i++)
                                        Column(
                                          children: [
                                            Card(
                                              elevation: 3,
                                              child: Container(
                                                padding: EdgeInsets.all(0),
                                                child: Row(
                                                  //mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Image(
                                                      image: AssetImage("images/Flutter.png"),
                                                      width: (size.width / 4) - 20,
                                                      height: (size.width / 4) - 20,
                                                    ),
                                                    Container(
                                                      width: 3 * (size.width / 4) - 30,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Flutter Review",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius.circular(10),
                                                            ),
                                                            padding: EdgeInsets.all(0),
                                                            child: RatingBarIndicator(
                                                              rating: 2.75,
                                                              itemBuilder: (context, index) =>
                                                                  Icon(
                                                                    Icons.star,
                                                                    color: Colors.blue,
                                                                  ),
                                                              itemCount: 5,
                                                              itemSize: 12,
                                                              direction: Axis.horizontal,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor .",
                                                              style: TextStyle(
                                                                fontFamily: "Candara",
                                                                fontSize: 15,
                                                              ),
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    )
                  ],
                ),
              );
            }
            else
              return Center(child: Container(child: CircularProgressIndicator(color: Colors.deepOrange,)));
          }
      ),);
  }
}

//hired popup
enum ConfirmAction { Reject, Invite }
Future<Future<ConfirmAction?>> _asyncConfirmDialog(
    BuildContext context, String id) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        //title: Text('Delete This Contact?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Center(
          child: Text(
            "Hired!!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Candara',
                color: Colors.blue[800]),
          ),
        ),
        content: Container(
          width: double.infinity,
          //height: Wrap(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Image.asset(
                    "images/Hired.png",
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Congrats!!",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "You Have Hired",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Pratyush Bisht",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                  //OutlinedButton(onPressed: () {}, child: Text('New Student')),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 59, 48, 214))),
                  child: Text(
                    'E-mail Congrats',
                    style: TextStyle(
                      fontFamily: 'Candara',
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

//write review
enum ConfirmAction2 { Reject, Invite }
Future<Future<ConfirmAction2?>> _asyncConfirmDialog2(
    BuildContext context, String id) async {
  return showDialog<ConfirmAction2>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        //title: Text('Delete This Contact?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        insetPadding: EdgeInsets.all(0),
        content: Container(
          width: double.infinity,
          //height: Wrap(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 25,
                      ),
                      Text(
                        "  Write a Review",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    //key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.only(left: 5, right: 5),
                            child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) return 'Enter your Name';
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
                                labelText: 'Enter your name',
                                labelStyle: TextStyle(
                                    fontFamily: "Candara", color: Colors.grey),
                                //prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                fillColor: Colors.grey,
                                focusColor: Colors.orangeAccent,
                              ),
                              // onSaved: (input) => _name = input!
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            //padding: EdgeInsets.only(left: 5, right: 5),
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
                                labelText: 'E-mail or Mobile no.',
                                labelStyle: TextStyle(
                                    fontFamily: "Candara", color: Colors.grey),
                                //prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                fillColor: Colors.grey,
                                focusColor: Colors.orangeAccent,
                              ),
                              // onSaved: (input) => _name = input!
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            unratedColor: Colors.amber.withAlpha(50),
                            itemCount: 5,
                            itemSize: 30,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              _rating = rating;
                              (context as Element).markNeedsBuild();
                            },
                            updateOnDrag: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 160,
                            //padding: EdgeInsets.only(left: 5, right: 5),
                            child: TextFormField(
                              expands: true,
                              maxLines: null,

                              validator: (input) {
                                if (input!.isEmpty) return 'Write Review';
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

                                labelText: 'Your Review',
                                labelStyle: TextStyle(
                                    fontFamily: "Candara", color: Colors.grey),
                                //prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                fillColor: Colors.grey,
                                focusColor: Colors.orangeAccent,
                              ),
                              // onSaved: (input) => _name = input!
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),

                  //OutlinedButton(onPressed: () {}, child: Text('New Student')),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 59, 48, 214))),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'Candara',
                    ),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    final Future<ConfirmAction3?> action =
                    await _asyncConfirmDialog3(context, "");
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

//review submitted
enum ConfirmAction3 { Reject, Invite }
Future<Future<ConfirmAction3?>> _asyncConfirmDialog3(
    BuildContext context, String id) async {
  return showDialog<ConfirmAction3>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        //title: Text('Delete This Contact?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: Container(
          width: double.infinity,
          //height: Wrap(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Image.asset(
                    "images/Review.png",
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Review Submitted",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                  //OutlinedButton(onPressed: () {}, child: Text('New Student')),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 59, 48, 214))),
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      fontFamily: 'Candara',
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

//schedule interview
late DateTime _selectedDate;
TextEditingController dateController = TextEditingController();
TextEditingController timeController = TextEditingController();

enum ConfirmAction4 { Reject, Invite }
Future<Future<ConfirmAction4?>> _asyncConfirmDialog4(
    BuildContext context, String id) async {

  return showDialog<ConfirmAction4>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {


      return AlertDialog(
        //title: Text('Delete This Contact?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        insetPadding: EdgeInsets.zero,
        content: Container(
          width: double.infinity,
          //height: Wrap(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 25,
                        ),
                        Text(
                          " Schedule an Interview",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      //key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              //padding: EdgeInsets.only(left: 5, right: 5),
                              child: TextFormField(
                                readOnly: true,
                                validator: (input) {
                                  if (dateController.text.isEmpty) return 'Enter date from list';
                                },
                                controller: dateController,
                                decoration: InputDecoration(
                                  //fillColor: Colors.white,
                                  prefixIcon: GestureDetector(
                                      onTap: (){
                                        _selectDate(context);
                                      },
                                      child: Icon(Icons.date_range,color: Colors.grey,)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.orangeAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(15)),
                                  labelText: 'Enter Date',
                                  labelStyle: TextStyle(
                                      fontFamily: "Candara", color: Colors.grey),
                                  //prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                  fillColor: Colors.grey,
                                  focusColor: Colors.orangeAccent,
                                ),
                                // onSaved: (input) => _name = input!
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              //padding: EdgeInsets.only(left: 5, right: 5),
                              child: TextFormField(
                                readOnly: true,
                                validator: (input) {
                                  if (input!.isEmpty) return 'Please select time';
                                },
                                controller: timeController,
                                decoration: InputDecoration(
                                  prefixIcon: GestureDetector(
                                      onTap: (){
                                        _selectTime(context);
                                      },
                                      child: Icon(Icons.access_time,color: Colors.grey,)),
                                  //fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.orangeAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(15)),
                                  labelText: 'Select time',
                                  labelStyle: TextStyle(
                                      fontFamily: "Candara", color: Colors.grey),
                                  //prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                  fillColor: Colors.grey,
                                  focusColor: Colors.orangeAccent,
                                ),
                                // onSaved: (input) => _name = input!
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 160,
                              //padding: EdgeInsets.only(left: 5, right: 5),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,

                                validator: (input) {
                                  if (input!.isEmpty) return 'Add comments';
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

                                  labelText: 'Add comments',
                                  labelStyle: TextStyle(
                                      fontFamily: "Candara", color: Colors.grey),
                                  //prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                  fillColor: Colors.grey,
                                  focusColor: Colors.orangeAccent,
                                ),
                                // onSaved: (input) => _name = input!
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),

                    //OutlinedButton(onPressed: () {}, child: Text('New Student')),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 59, 48, 214))),
                  child: Row(
                    children: [
                      Icon(Icons.access_time,color: Colors.white,size: 20,),
                      Text(
                        '  Schedule',
                        style: TextStyle(
                          fontFamily: 'Candara',
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                    final Future<ConfirmAction5?> action =
                    await _asyncConfirmDialog5(context, "");
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

//moved to interview popup
enum ConfirmAction5 { Reject, Invite }
Future<Future<ConfirmAction5?>> _asyncConfirmDialog5(
    BuildContext context, String id) async {
  return showDialog<ConfirmAction5>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        //title: Text('Delete This Contact?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),

        content: Container(
          width: double.infinity,
          //height: Wrap(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Image.asset(
                    "images/interview.png",
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Pratyush\nis moved to\nthe Interview page",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 59, 48, 214))),
                  child: Text(
                    'Interview Page',
                    style: TextStyle(
                      fontFamily: 'Candara',
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

_selectDate(BuildContext context) async {
  DateTime? newSelectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2010, 1),
    lastDate: DateTime(2025, 12),
  ).then((pickedDate) {
    //do whatever you want
    if(pickedDate!=null){
      dateController.text = pickedDate.toString().split(" ")[0];
    }});

  if (newSelectedDate != null) {
    _selectedDate = newSelectedDate;
    dateController
      ..text = DateFormat.yMMMd().format(_selectedDate)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: dateController.text.length,
          affinity: TextAffinity.upstream));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

_selectTime(BuildContext context) async {
  DateTime? newSelectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now()

  ).then((pickedTime) {
    //do whatever you want
    if(pickedTime!=null){
      timeController.text = pickedTime.toString().split("(")[1].split(")")[0];
    }});

  if (newSelectedTime != null) {
    _selectedDate = newSelectedTime;
    timeController
      ..text = DateFormat.yMMMd().format(_selectedDate)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: dateController.text.length,
          affinity: TextAffinity.upstream));
  }
}



