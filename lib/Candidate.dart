import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_app/Dashboard.dart';
import 'package:hire_app/SeeAll.dart';
import 'package:hire_app/video.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'globals.dart';

var _id,_name,_email,_phone;
int interview_code=0;
int shortlist_code=0;
int mob=0,emailc=0,res=0,vid=0;
int put_hold=0;
int reject_code=0;
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
    this.isCandidate,
    required this.stages,
    required this.psychometricsResult,
  });

  FullProfile candidate;
  List <Education> educations;
  List <Employment> employments;
  List<Feedback> feedback;
  var isCandidate;
  List<Stage> stages;
  PsychometricsResult psychometricsResult;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    candidate: FullProfile.fromJson(json["candidate"]),
    educations: List<Education>.from(json["educations"].map((x) => Education.fromJson(x))),
    employments: List<Employment>.from(json["employments"].map((x) => Employment.fromJson(x))),
    feedback: List<Feedback>.from(json["feedback"].map((x) => Feedback.fromJson(x))),
    isCandidate: json["is_candidate"],
    stages: List<Stage>.from(json["stages"].map((x) => Stage.fromJson(x))),
    psychometricsResult: PsychometricsResult.fromJson(json["psychometrics_result"]),
  );

  Map<String, dynamic> toJson() => {
    "candidate": candidate.toJson(),
    "educations": List<Education>.from(educations.map((x) => x.toJson())),
    "employments": List<Employment>.from(employments.map((x) => x.toJson())),
    "feedback": List<dynamic>.from(feedback.map((x) => x.toJson())),
    "is_candidate" : isCandidate,
    "stages": List<dynamic>.from(stages.map((x) => x.toJson())),
    "psychometrics_result": psychometricsResult.toJson(),
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
    this.heading,
    this.rating,
    this.text,
    this.uploadedBy,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var userId;
  var heading;
  var rating;
  var text;
  var uploadedBy;
  var createdAt;
  var updatedAt;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    id: json["id"],
    userId: json["user_id"],
    heading: json["heading"],
    rating: json["rating"],
    text: json["text"],
    uploadedBy: json["uploaded_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "heading": heading,
    "rating": rating,
    "text": text,
    "uploaded_by": uploadedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
class Stage {
  Stage({
    this.id,
    this.displayValue,
    this.key,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var displayValue;
  var key;
  var status;
  var createdAt;
  var updatedAt;

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
    id: json["id"],
    displayValue: json["display_value"],
    key: json["key"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "display_value": displayValue,
    "key": key,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
class PsychometricsResult {
  PsychometricsResult({
    this.id,
    this.type,
    this.name,
    this.summary,
    this.description,
    this.traits,
    this.strengths,
    this.weakness,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var type;
  var name;
  var summary;
  var description;
  var traits;
  var strengths;
  var weakness;
  var createdAt;
  var updatedAt;

  factory PsychometricsResult.fromJson(Map<String, dynamic> json) => PsychometricsResult(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    summary: json["summary"],
    description: json["description"],
    traits: json["traits"],
    strengths: json["strengths"],
    weakness: json["weakness"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "summary": summary,
    "description": description,
    "traits": traits,
    "strengths": strengths,
    "weakness": weakness,
    "created_at": createdAt,
    "updated_at": updatedAt
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
Interview interviewFromJson(String str) => Interview.fromJson(json.decode(str));
String interviewToJson(Interview data) => json.encode(data.toJson());

class Interview {
  Interview({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<String> data;
  String message;

  factory Interview.fromJson(Map<String, dynamic> json) => Interview(
    success: json["success"],
    data: List<String>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x)),
    "message": message,
  };
}

Future<Interview> INTERVIEWapi (String id, String Round,String name, String email, String meetingType, String date, String time,String linkPhone ,String comment) async {
  final String apiUrl =
      "${BASE}api/candidate/next/round";
  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: {
        "candidate_id":id,
        "round" : Round,
        "name":name,
        "email":email,
        "date":date,
        "time":time,
        "meeting_type":meetingType,
        "meeting_link":linkPhone,
        "phone":linkPhone,
        "feedback":comment
      });

  if (response.statusCode == 200) {
    interview_code=200;
    print("INTERVIEW SCHEDULED");
    final String responseString = response.body;
    debugPrint(response.body);
    return interviewFromJson(responseString);
  }
  if(response.statusCode == 401) {
    interview_code=401;
    Interview b=new  Interview(success: false, data: [], message: "");
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}
Future<Interview> Hireapi (String id,String ctc,String job, String joindate,) async {
  final String apiUrl =
      "${BASE}api/candidate/next/round";
  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: {
        "candidate_id":id,
        "round" : "candidate-selected",
        "joining_date":joindate,
        "offered_ctc":ctc,
        "job_title":job

      });

  if (response.statusCode == 200) {
    interview_code=200;
    print("hired");
    final String responseString = response.body;
    debugPrint(response.body);
    return interviewFromJson(responseString);
  }
  if(response.statusCode == 401) {
    interview_code=401;
    Interview b=new  Interview(success: false, data: [], message: "");
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}

Shortlist shortlistFromJson(String str) => Shortlist.fromJson(json.decode(str));
String shortlistToJson(Shortlist data) => json.encode(data.toJson());
class Shortlist {
  Shortlist({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  List<String> data;
  String message;

  factory Shortlist.fromJson(Map<String, dynamic> json) => Shortlist(
    success: json["success"],
    data: List<String>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x)),
    "message": message,
  };
}

Future<Shortlist> shortlistapi (String id) async {
  final String apiUrl =
      "${BASE}api/candidate/shortlist";
  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: {
        "candidate_id":id,
      });

  if (response.statusCode == 200) {
    shortlist_code=200;
    print("shortlisted");
    final String responseString = response.body;
    debugPrint(response.body);
    return shortlistFromJson(responseString);
  }
  if(response.statusCode == 401) {
    shortlist_code=401;
    Shortlist b=new  Shortlist(success: false, data: [], message: "");
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}
Future<Shortlist> putholdapi (String id) async {
  final String apiUrl =
      "${BASE}api/candidate/put-hold";
  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: {
        "candidate_id":id,
      });

  if (response.statusCode == 200) {
    put_hold=200;
    print("puthold");
    final String responseString = response.body;
    debugPrint(response.body);
    return shortlistFromJson(responseString);
  }
  if(response.statusCode == 401) {
    put_hold=401;
    Shortlist b=new  Shortlist(success: false, data: [], message: "");
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}
Future<Shortlist> rejectapi (String id,String reason, String remark) async {
  final String apiUrl =
      "${BASE}api/candidate/rejected";
  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: {
        "candidate_id":id,
        "reason":reason,
        "remarks":remark
      });

  if (response.statusCode == 200) {
    reject_code=200;
    print("shortlisted");
    final String responseString = response.body;
    debugPrint(response.body);
    return shortlistFromJson(responseString);
  }
  if(response.statusCode == 401) {
    reject_code=401;
    Shortlist b=new  Shortlist(success: false, data: [], message: "");
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}

Mobileview mobileviewFromJson(String str) => Mobileview.fromJson(json.decode(str));

String mobileviewToJson(Mobileview data) => json.encode(data.toJson());

class Mobileview {
  Mobileview({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data1 data;
  String message;

  factory Mobileview.fromJson(Map<String, dynamic> json) => Mobileview(
    success: json["success"],
    data: Data1.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}
class Data1 {
  Data1({
    this.mobile,
    this.email,
    this.video,
    this.resume,
    this.status
  });

  var mobile;
  var email;
  var video;
  var resume;
  var status;

  factory Data1.fromJson(Map<String, dynamic> json) => Data1(
    mobile: json["mobile"],
    email: json["email"],
    video: json["video"],
    resume: json["resume"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "video": video,
    "resume":resume,
    "email":email,
    "status": status
  };
}

//view details
Future<Mobileview> viewmob (String id) async {
  final String apiUrl =
      "${BASE}api/candidate/data/view/request";
  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: {
        "access_type":"mobile",
        "candidate":id,
      });

  if (response.statusCode == 200) {
    mob=200;
    final String responseString = response.body;
    debugPrint(response.body);
    return mobileviewFromJson(responseString);
  }
  if(response.statusCode == 401) {
    mob=401;
    Mobileview b=new  Mobileview(success: false, data: Data1(), message: "");
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}
Future<Mobileview> viewemail (String id) async {
  final String apiUrl =
      "${BASE}api/candidate/data/view/request";
  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: {
        "access_type":"email",
        "candidate":id,
      });

  if (response.statusCode == 200) {
    emailc=200;
    final String responseString = response.body;
    debugPrint(response.body);
    return mobileviewFromJson(responseString);
  }
  if(response.statusCode == 401) {
    emailc=401;
    Mobileview b=new  Mobileview(success: false, data: Data1(), message: "");
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}

//statusview
Future<Mobileview> statmob (String id) async {
  final String apiUrl =
      "${BASE}api/candidate/data/view/status";
  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: {
        "access_type":"mobile",
        "candidate":id,
      });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    debugPrint(response.body);
    return mobileviewFromJson(responseString);
  }
  if(response.statusCode == 401) {
    Mobileview b=new  Mobileview(success: false, data: Data1(), message: "");
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}
Future<Mobileview> statemail (String id) async {
  final String apiUrl =
      "${BASE}api/candidate/data/view/status";
  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
      body: {
        "access_type":"email",
        "candidate":id,
      });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    debugPrint(response.body);
    return mobileviewFromJson(responseString);
  }
  if(response.statusCode == 401) {
    Mobileview b=new  Mobileview(success: false, data: Data1(), message: "");
    return b;
  }
  else {
    throw Exception('Failed to load album');
  }
}




var _rating;

class Candidate extends StatefulWidget {
  //const Candidate({Key? key}) : super(key: key);
  var c_id;

  Candidate(this.c_id);

  @override
  _CandidateState createState() => _CandidateState(c_id);
}

class _CandidateState extends State<Candidate> {
  bool psyc_vis = true, int_vis = false, rev_vis = false;
  List<bool> isSelected = List.generate(3, (index) => false);
  List<bool> isSelected1 = List.generate(2, (index) => false);
  int c = 0;
  int e=0;
  var c_id;
  String _dropDownValue="";
  String candidate_phone="XXX-XXX-XXXX";
  String candidate_email="axx@bxx.com";
  bool M_o_eye=false,M_c_eye=true,eml_c_eye=true,eml_o_eye=false;


  _CandidateState(this.c_id);

  String? _thumbnailFile;

  String? _thumbnailUrl="https://player.vimeo.com/video/730702418?h=464cdef220";


  @override
  void initState() {
    super.initState();
  }


  void generateThumbnail(String url) async {


    _thumbnailUrl = await VideoThumbnail.thumbnailFile(
        video:
        "${url}",
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,

    );
    setState(() {

    });





  }


  @override
  Widget build(BuildContext context) {



    _c_id=c_id;
    isSelected[c] = true;
    isSelected1[e]=true;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body:FutureBuilder(
            future: getCandidateProf(_c_id),
            builder: (context,AsyncSnapshot<Candidateprofile> snapshot) {
              print(snapshot.data);
              if (snapshot.hasData)
              {
                //generateThumbnail(snapshot.data!.data.feedback[snapshot.data!.data.feedback.length-1].text.toString());

                _id=snapshot.data!.data.candidate.userId.toString();
                _name=snapshot.data!.data.candidate.name.toString();
                _email=snapshot.data!.data.candidate.email.toString();
                _phone=snapshot.data!.data.candidate.mobile.toString();
                String img;
                if(snapshot.data!.data.candidate.profileImage.toString()=="null")
                  img="http://kobl.ai/img/profile.png";
                else
                  img=snapshot.data!.data.candidate.profileImage.toString();
                return Scaffold(
                  backgroundColor: Colors.white,
                  bottomNavigationBar:
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(snapshot.data!.data.isCandidate.toString()==""|| snapshot.data!.data.isCandidate.toString()=="released"&&snapshot.data!.data.isCandidate.toString()!="Rejected" && snapshot.data!.data.isCandidate.toString()!="Candidate selected"&&snapshot.data!.data.isCandidate.toString()!="Put on hold"&&snapshot.data!.data.isCandidate.toString()!="short-listed")
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
                                '  Shortlist',
                                style: TextStyle(
                                    fontFamily: 'Candara',
                                    fontSize: 16,
                                    color: Colors.orangeAccent),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
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
                                                  " Shortlist Candidate",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold, fontSize: 25),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Do you want to \nshortlist ${snapshot.data!.data.candidate.name.toString()}?",
                                              style: TextStyle(fontSize: 25),
                                              textAlign: TextAlign.center,
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
                                              Icon(Icons.check_circle_outline,color: Colors.white,size: 20,),
                                              Text(
                                                ' Okay',
                                                style: TextStyle(
                                                  fontFamily: 'Candara',
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () async {
                                            Shortlist B= await shortlistapi(snapshot.data!.data.candidate.userId.toString());
                                            if(shortlist_code==200){
                                              Navigator.pop(context);
                                              showDialog(
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
                                                                "${snapshot.data!.data.candidate.name.toString()}\nis moved to\nthe Shortlist stage",
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
                                                                'Okay',
                                                                style: TextStyle(
                                                                  fontFamily: 'Candara',
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                                setState(() {

                                                                });

                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                              /*final Future<ConfirmAction5?> action =await _asyncConfirmDialog5(context, "",name);*/

                                            }

                                          },
                                        ),
                                        SizedBox(width: 10,),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(
                                                  Color.fromARGB(255, 59, 48, 214))),
                                          child: Row(
                                            children: [
                                              Icon(Icons.radio_button_unchecked,color: Colors.white,size: 20,),
                                              Text(
                                                ' Cancel',
                                                style: TextStyle(
                                                  fontFamily: 'Candara',
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () async {
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

                          },
                      ),
                      if(snapshot.data!.data.isCandidate.toString()!="" &&snapshot.data!.data.isCandidate.toString()!="Rejected"&&snapshot.data!.data.isCandidate.toString()!="Candidate Selected" && snapshot.data!.data.isCandidate.toString()!="released")
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
                                  '  Move next round',
                                  style: TextStyle(
                                      fontFamily: 'Candara',
                                      fontSize: 15,
                                      color: Colors.orangeAccent),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () async {

                            showDialog(
                              context: context,
                              barrierDismissible: false, // user must tap button for close dialog!
                              builder: (BuildContext context) {

                                String? _character="Video";
                                isSelected1[e]=true;
                                List<String> drop=[];
                                for(var i=0;i<snapshot.data!.data.stages.length-1;i++)
                                  {
                                    drop.add(snapshot.data!.data.stages[i].key.toString());
                                  }


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
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.arrow_back_ios,
                                                      color: Colors.black,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  Text(
                                                    " Schedule an Interview    ",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold, fontSize: 25),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: <Widget>[
                                                      Text(
                                                        "  Select Round",
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontFamily: 'Candara',
                                                        ),
                                                      ),

                                                      FormField<String>(
                                                        builder: (FormFieldState<String> state) {
                                                          String _currentSelectedValue='';
                                                          return Container(
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 0,right: 0),
                                                            child: InputDecorator(
                                                              decoration: InputDecoration(
                                                                //labelText: 'CLASS',
                                                                  prefixIcon: Icon(Icons.leaderboard,color: Colors.grey),
                                                                  labelStyle: TextStyle(fontFamily: "Candara"),
                                                                  errorStyle: TextStyle(fontFamily:"Candara",color: Colors.redAccent, fontSize: 16.0),
                                                                  //hintText: 'Please select expense',
                                                                  enabledBorder:OutlineInputBorder(
                                                                      borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                                                      borderRadius: BorderRadius.circular(15)),
                                                                  focusedBorder: OutlineInputBorder(
                                                                      borderSide: const BorderSide(color: Colors.orangeAccent,width: 2.0),
                                                                      borderRadius: BorderRadius.circular(15)
                                                                  )),
                                                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                              isEmpty: _currentSelectedValue == '',
                                                              child: DropdownButtonHideUnderline(
                                                                  child: DropdownButton(
                                                                    menuMaxHeight: 200,
                                                                    hint: _dropDownValue == null
                                                                        ? Text('Dropdown')
                                                                        : Text(
                                                                      _dropDownValue,
                                                                      style: TextStyle(fontFamily: "Candara",color: Colors.black,fontSize: 16),
                                                                    ),
                                                                    isExpanded: false,
                                                                    iconSize: 30.0,
                                                                    style: TextStyle(color: Colors.black),
                                                                    items: drop.map(
                                                                          (val) {
                                                                        return DropdownMenuItem<String>(
                                                                          value: val,
                                                                          child: Text(val),
                                                                        );
                                                                      },
                                                                    ).toList(),
                                                                    onChanged: (String? val) {
                                                                      setState(() {
                                                                        _dropDownValue = val!;
                                                                      });

                                                                      (context as Element).markNeedsBuild();

                                                                    },
                                                                  )
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(height: 20),
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
                                                      SizedBox(height: 20,),
                                                      Container(
                                                        //padding: EdgeInsets.only(left: 5, right: 5),
                                                        child: TextFormField(
                                                          validator: (input) {
                                                            if (input!.isEmpty) return 'Enter Interviewer Name';
                                                          },
                                                          controller: intnameController,
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
                                                            labelText: 'Enter interviewer name',
                                                            labelStyle: TextStyle(
                                                                fontFamily: "Candara", color: Colors.grey),
                                                            prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
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
                                                            if (input!.isEmpty) return 'Enter interviewer E-mail';
                                                          },
                                                          controller: intmailController,
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
                                                            labelText: 'Interviewer E-mail ',
                                                            labelStyle: TextStyle(
                                                                fontFamily: "Candara", color: Colors.grey),
                                                            prefixIcon: Icon(Icons.mail_outline, color: Colors.grey),
                                                            fillColor: Colors.grey,
                                                            focusColor: Colors.orangeAccent,
                                                          ),
                                                          // onSaved: (input) => _name = input!
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Center(
                                                        child: SingleChildScrollView(
                                                          scrollDirection: Axis.horizontal,
                                                          child: Center(
                                                            child: ToggleButtons(
                                                              children: <Widget>[
                                                                Text("  Video  ",
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                      fontFamily: "Candara",
                                                                    )),
                                                                Text("  Phone  ",
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
                                                                  e=index;
                                                                  for (int buttonIndex = 0;
                                                                  buttonIndex < isSelected1.length;
                                                                  buttonIndex++) {
                                                                    if (buttonIndex == index) {
                                                                      isSelected1[buttonIndex] = true;
                                                                    } else {
                                                                      isSelected1[buttonIndex] = false;
                                                                    }

                                                                  }


                                                                });
                                                                (context as Element).markNeedsBuild();
                                                              },
                                                              isSelected: isSelected1,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20,),
                                                      if(e==0)
                                                        Container(
                                                        //padding: EdgeInsets.only(left: 5, right: 5),
                                                        child: TextFormField(
                                                          //readOnly: true,
                                                          validator: (input) {
                                                            if (input!.isEmpty && e==0) return 'Please enter meetlink';
                                                          },
                                                          controller: meetlink,
                                                          decoration: InputDecoration(
                                                            prefixIcon: Icon(Icons.video_call,color: Colors.grey,),
                                                            //fillColor: Colors.white,
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Colors.grey, width: 2.0),
                                                                borderRadius: BorderRadius.circular(15)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Colors.orangeAccent, width: 2.0),
                                                                borderRadius: BorderRadius.circular(15)),
                                                            labelText: 'Enter meet link',
                                                            labelStyle: TextStyle(
                                                                fontFamily: "Candara", color: Colors.grey),
                                                            //prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                                            fillColor: Colors.grey,
                                                            focusColor: Colors.orangeAccent,
                                                          ),
                                                          // onSaved: (input) => _name = input!
                                                        ),
                                                      ),
                                                      if(e==1)
                                                        Container(
                                                          //padding: EdgeInsets.only(left: 5, right: 5),
                                                          child: TextFormField(
                                                            //readOnly: true,
                                                            validator: (input) {
                                                              if (input!.isEmpty && e==1) return 'Please enter phone';
                                                            },
                                                            controller: phonelink,
                                                            keyboardType: TextInputType.phone,
                                                            decoration: InputDecoration(
                                                              prefixIcon: Icon(Icons.phone,color: Colors.grey,),
                                                              //fillColor: Colors.white,
                                                              enabledBorder: OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color: Colors.grey, width: 2.0),
                                                                  borderRadius: BorderRadius.circular(15)),
                                                              focusedBorder: OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color: Colors.orangeAccent, width: 2.0),
                                                                  borderRadius: BorderRadius.circular(15)),
                                                              labelText: 'Enter phone no.',
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
                                                        height: 15,
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
                                                          controller: comments,
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
                                              if(_formKey.currentState!.validate()&& _dropDownValue!="")
                                              {
                                                String date= dateController.text;
                                                String time= timeController.text;
                                                String link;
                                                String commet= comments.text;
                                                String type;
                                                if(e==0) {
                                                  type = "Video";
                                                  link=meetlink.text;
                                                }
                                                else
                                                  {
                                                  type="Audio";
                                                  link=phonelink.text;
                                                  }


                                                Interview log = await INTERVIEWapi(snapshot.data!.data.candidate.userId.toString(),_dropDownValue,intnameController.text,intmailController.text,type,date,time,link,commet);

                                                if(interview_code==200) {
                                                  Navigator.pop(context);
                                                  showDialog<ConfirmAction7>(
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
                                                                    "${_name}\nis moved \nto the next stage",
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
                                                                    'OKAY',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Candara',
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                    setState(() {

                                                                    });

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

                                                if(interview_code==401){
                                                  Navigator.pop(context);
                                                  showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext context) => AlertDialog(
                                                        title: const Text("Try Again"),
                                                        content: const Text("Couldn't schedule interview"),
                                                        actions: <Widget>[
                                                          TextButton(
                                                              onPressed: () => Navigator.pop(context, 'OK'),
                                                              child: const Text('OK',style: TextStyle(color: Colors.teal))
                                                          ),
                                                        ],
                                                      ));
                                                }
                                              }


                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      if(snapshot.data!.data.isCandidate.toString()!="Candidate Selected" && snapshot.data!.data.isCandidate.toString()!="Rejected")
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
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button for close dialog!
                            builder: (BuildContext context) {
                              dateController=TextEditingController();
                              ctcoffered=TextEditingController();
                              jobprof=TextEditingController();
                              _name=snapshot.data!.data.candidate.name.toString();

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
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.pop(context);
                                                  },
                                                  child: Icon(
                                                    Icons.arrow_back_ios,
                                                    color: Colors.black,
                                                    size: 25,
                                                  ),
                                                ),
                                                Text(
                                                  " Do you want to hire ${snapshot.data!.data.candidate.name.toString().split(" ")[0]}?",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold, fontSize: 25),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Form(
                                                key: _formKey1,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: <Widget>[

                                                    Container(
                                                      //padding: EdgeInsets.only(left: 5, right: 5),
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        validator: (input) {
                                                          if (dateController.text.isEmpty) return 'Enter CTC offered';
                                                        },
                                                        controller: ctcoffered,
                                                        decoration: InputDecoration(
                                                          //fillColor: Colors.white,
                                                          prefixIcon: Icon(Icons.monetization_on_outlined,color: Colors.grey,),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Colors.grey, width: 2.0),
                                                              borderRadius: BorderRadius.circular(15)),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Colors.orangeAccent, width: 2.0),
                                                              borderRadius: BorderRadius.circular(15)),
                                                          labelText: 'Enter CTC',
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
                                                          if (input!.isEmpty) return 'Please select join Date';
                                                        },
                                                        controller: dateController,
                                                        decoration: InputDecoration(
                                                          prefixIcon: GestureDetector(
                                                              onTap: (){
                                                                _selectDate(context);
                                                              },
                                                              child: Icon(Icons.date_range,color: Colors.grey,)),
                                                          //fillColor: Colors.white,
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Colors.grey, width: 2.0),
                                                              borderRadius: BorderRadius.circular(15)),
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                  color: Colors.orangeAccent, width: 2.0),
                                                              borderRadius: BorderRadius.circular(15)),
                                                          labelText: 'Select join date',
                                                          labelStyle: TextStyle(
                                                              fontFamily: "Candara", color: Colors.grey),
                                                          //prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                                          fillColor: Colors.grey,
                                                          focusColor: Colors.orangeAccent,
                                                        ),
                                                        // onSaved: (input) => _name = input!
                                                      ),
                                                    ),
                                                    SizedBox(height: 20,),
                                                    Container(
                                                      //padding: EdgeInsets.only(left: 5, right: 5),
                                                      child: TextFormField(
                                                        validator: (input) {
                                                          if (input!.isEmpty) return 'Enter Job Designation';
                                                        },
                                                        controller: jobprof,
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
                                                          labelText: 'Enter Job designation',
                                                          labelStyle: TextStyle(
                                                              fontFamily: "Candara", color: Colors.grey),
                                                          prefixIcon: Icon(Icons.person_outline_sharp, color: Colors.grey),
                                                          fillColor: Colors.grey,
                                                          focusColor: Colors.orangeAccent,
                                                        ),
                                                        // onSaved: (input) => _name = input!
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),

                                                  ],
                                                )),


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
                                              Icon(Icons.check_circle_outline,color: Colors.white,size: 20,),
                                              Text(
                                                '  Hire',
                                                style: TextStyle(
                                                  fontFamily: 'Candara',
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () async {
                                            if(_formKey1.currentState!.validate())
                                            {
                                              String date= dateController.text;

                                              Interview log = await Hireapi(snapshot.data!.data.candidate.userId.toString(),ctcoffered.text, jobprof.text, date);

                                              if(interview_code==200) {
                                                Navigator.pop(context);
                                                final Future<ConfirmAction?> action = await _asyncConfirmDialog(context, "");
                                              }

                                              if(interview_code==401){
                                                Navigator.pop(context);
                                                showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) => AlertDialog(
                                                      title: const Text("Try Again"),
                                                      content: const Text("Couldn't schedule interview"),
                                                      actions: <Widget>[
                                                        TextButton(
                                                            onPressed: () => Navigator.pop(context, 'OK'),
                                                            child: const Text('OK',style: TextStyle(color: Colors.teal))
                                                        ),
                                                      ],
                                                    ));
                                              }
                                            }


                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

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
                            GestureDetector(
                              onTap: (){
                                showDialog(
                                  context: context,
                                  barrierDismissible: false, // user must tap button for close dialog!
                                  builder: (BuildContext context) {
                                    return  Container(

                                      child: VideoPlayerApp(snapshot.data!.data.feedback[snapshot.data!.data.feedback.length-1].text.toString()),

                                    );
                                  },
                                );
                              },
                              child: Container(
                              padding: EdgeInsets.all(15),
                              height: (size.height) / 2.2,
                              width: (size.width),
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  image: DecorationImage(
                                      image: NetworkImage("${img}"),
                                      fit: BoxFit.fill)),
                              child: Stack(
                                children: [

                                  Center(child: Card(
                                    shape :RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    color: Colors.deepOrangeAccent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.play_circle_fill,color: Colors.white,size: 45,),
                                    ),
                                  ) ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Row(
                                            children: [

                                              SizedBox(
                                                width: 5,
                                              ),
                                              if(snapshot.data!.data.isCandidate.toString()!="")
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(15)),
                                                  child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                      "Stage : ${snapshot.data!.data.isCandidate}",
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
                                            color: Colors.black,
                                          )),
                                      SizedBox(height: 110,),
                                      /*Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15)),
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.arrow_back,size: 20,),
                                                  Text(
                                                    "Swipe Left",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )*/
                                    ],
                                  ),
                                ],
                              ),
                          ),
                            ),



                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                          height: (size.height) - (size.height) / 2.8,
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
                                      if(snapshot.data!.data.isCandidate.toString()=="short-listed")
                                        GestureDetector(
                                          onTap: () async {
                                            Shortlist B= await shortlistapi(snapshot.data!.data.candidate.userId.toString());
                                            if(shortlist_code==200){
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false, // user must tap button for close dialog!
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    //title: Text('Delete This Contact?'),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(15))),
                                                    title: Center(
                                                      child: Text(
                                                        "Released ${snapshot.data!.data.candidate.name.toString()}",
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

                                                              Text(
                                                                "You Have successfully ",
                                                                style: TextStyle(fontSize: 20),
                                                              ),
                                                              Text(
                                                                "released ${snapshot.data!.data.candidate.name.toString()}",
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
                                                              onPressed: () {

                                                                Navigator.pop(context);
                                                                setState(() {

                                                                });
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
                                          },
                                          child: Card(
                                            color: Colors.redAccent,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.remove_circle_outline,color: Colors.white,size: 18,),
                                                  //Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                  SizedBox(width: 5,),
                                                  Text("Release",style: TextStyle(color: Colors.white,fontSize: 15),),
                                                ],
                                              ),
                                            ),
                                          )
                                      ),
                                      Row(
                                        children: [
                                          if(snapshot.data!.data.isCandidate.toString()!="short-listed"&&snapshot.data!.data.isCandidate.toString()!="Rejected"&&snapshot.data!.data.isCandidate.toString()!="released"&&snapshot.data!.data.isCandidate.toString()!="Candidate Selected"&&snapshot.data!.data.isCandidate.toString()!="")
                                            GestureDetector(
                                                onTap: () async {

                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false, // user must tap button for close dialog!
                                                    builder: (BuildContext context) {
                                                      remarks=TextEditingController();
                                                      reasons=TextEditingController();
                                                      return AlertDialog(
                                                        //title: Text('Delete This Contact?'),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(15))),
                                                        title: Center(
                                                          child: Text(
                                                            "Reject ${snapshot.data!.data.candidate.name.toString()}?",
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
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Form(
                                                                  key: _formKey2,
                                                                  child: Column(
                                                                    mainAxisSize: MainAxisSize.max,
                                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                    children: <Widget>[

                                                                      Container(
                                                                        //padding: EdgeInsets.only(left: 5, right: 5),
                                                                        child: TextFormField(
                                                                          keyboardType: TextInputType.number,
                                                                          validator: (input) {
                                                                            if (dateController.text.isEmpty) return ' Enter Reasons';
                                                                          },
                                                                          controller: reasons,
                                                                          decoration: InputDecoration(
                                                                            //fillColor: Colors.white,
                                                                            prefixIcon: Icon(Icons.help,color: Colors.grey,),
                                                                            enabledBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                    color: Colors.grey, width: 2.0),
                                                                                borderRadius: BorderRadius.circular(15)),
                                                                            focusedBorder: OutlineInputBorder(
                                                                                borderSide: const BorderSide(
                                                                                    color: Colors.orangeAccent, width: 2.0),
                                                                                borderRadius: BorderRadius.circular(15)),
                                                                            labelText: 'Enter Reason',
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
                                                                        height: 160,
                                                                        //padding: EdgeInsets.only(left: 5, right: 5),
                                                                        child: TextFormField(
                                                                          expands: true,
                                                                          maxLines: null,

                                                                          validator: (input) {
                                                                            if (input!.isEmpty) return 'Add Remarks';
                                                                          },
                                                                          controller: remarks,
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

                                                                            labelText: 'Add Remarks',
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
                                                                    'Reject',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Candara',
                                                                    ),
                                                                  ),
                                                                  onPressed: () async{
                                                                    if(_formKey2.currentState!.validate()) {
                                                                      Shortlist c = await rejectapi(
                                                                          snapshot.data!.data.candidate.userId.toString(),
                                                                          reasons.text,
                                                                          remarks.text);
                                                                      if (reject_code == 200)
                                                                      {
                                                                        Navigator.pop(context);
                                                                        showDialog(
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
                                                                                          Text(
                                                                                            " Rejected ${snapshot.data!.data.candidate.name.toString()} successfully",
                                                                                            style: TextStyle(
                                                                                                fontWeight: FontWeight.bold, fontSize: 25),
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
                                                                                            Icon(Icons.check_circle_outline,color: Colors.white,size: 20,),
                                                                                            Text(
                                                                                              '  Okay',
                                                                                              style: TextStyle(
                                                                                                fontFamily: 'Candara',
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        onPressed: () async {
                                                                                          Navigator.pop(context);
                                                                                          Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                  builder: (context) => Dashboard()));

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

                                                                    }
                                                                  },
                                                                ),
                                                                SizedBox(width: 20,),
                                                                ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                                          Color.fromARGB(255, 59, 48, 214))),
                                                                  child: Text(
                                                                    'Cancel',
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

                                                },
                                                child: Card(
                                                  color: Colors.redAccent,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.remove_circle_outline,color: Colors.white,size: 15,),
                                                        //Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                        SizedBox(width: 5,),
                                                        Text("Reject",style: TextStyle(color: Colors.white,fontSize: 14),),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ),
                                          if(snapshot.data!.data.isCandidate.toString()!="short-listed"&&snapshot.data!.data.isCandidate.toString()!="Rejected"&&snapshot.data!.data.isCandidate.toString()!="released"&&snapshot.data!.data.isCandidate.toString()!="Candidate Selected"&&snapshot.data!.data.isCandidate.toString()!="")
                                            GestureDetector(
                                                onTap: () async {
                                                  Shortlist B= await putholdapi(snapshot.data!.data.candidate.userId.toString());
                                                  if(put_hold==200){
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false, // user must tap button for close dialog!
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          //title: Text('Delete This Contact?'),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(15))),
                                                          title: Center(
                                                            child: Text(
                                                              "Put on hold successfull!!",
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

                                                                    Text(
                                                                      "${snapshot.data!.data.candidate.name.toString()}",
                                                                      style: TextStyle(fontSize: 20),
                                                                    ),
                                                                    Text(
                                                                      "has been put on hold",
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
                                                                    onPressed: () {

                                                                      Navigator.pop(context);
                                                                      setState(() {

                                                                      });
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
                                                },
                                                child: Card(
                                                  color: Colors.blueAccent,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.stop_circle,color: Colors.white,size: 15,),
                                                        //Image(image: AssetImage("images/google.png"),height: 15,width: 15,),
                                                        SizedBox(width: 5,),
                                                        Text("Put on hold",style: TextStyle(color: Colors.white,fontSize: 14),),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            )
                                        ],
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Interview Availability",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "Candara",
                                                  color: Colors.grey)),
                                          Text("  Online",
                                              style: TextStyle(
                                                  fontFamily: "Candara",
                                                  fontSize: 18,
                                                  color: Colors.green)),
                                        ],
                                      ),
                                      if(snapshot.data!.data.candidate.working_mode.toString()=="1")
                                      Card(
                                        elevation: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text("Full time",
                                              style: TextStyle(
                                                  fontFamily: "Candara",
                                                  fontSize: 18,
                                                  color: Colors.blue)),
                                        ),
                                      ),
                                      if(snapshot.data!.data.candidate.working_mode.toString()=="2")
                                        Card(
                                          elevation: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Text("Freelancer",
                                                style: TextStyle(
                                                    fontFamily: "Candara",
                                                    fontSize: 18,
                                                    color: Colors.blue)),
                                          ),
                                        ),
                                      if(snapshot.data!.data.candidate.working_mode.toString()=="3")
                                        Card(
                                          elevation: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Text("Hybrid",
                                                style: TextStyle(
                                                    fontFamily: "Candara",
                                                    fontSize: 18,
                                                    color: Colors.blue)),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  SizedBox(height: 10),
                                  if(snapshot.data!.data.candidate.overview.toString()!="null")
                                  Text(
                                          "${snapshot.data!.data.candidate.overview.toString()}",
                                      style: TextStyle(
                                        fontFamily: "Candara",
                                        fontSize: 15
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),


                                  Row(
                                    children: [
                                      Text("Designation : ",
                                          style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      Text("${snapshot.data!.data.candidate.designation.toString()}",
                                          style:
                                          TextStyle(fontSize: 15,)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("CTC : ",
                                          style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      Text("${snapshot.data!.data.candidate.ctc.toString()} LPA",
                                          style:
                                          TextStyle(fontSize: 15,)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [
                                      Text("Experience : ",
                                          style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      if(snapshot.data!.data.candidate.exp.toString()!="1")
                                      Text("${snapshot.data!.data.candidate.exp.toString()} yrs",
                                          style:
                                          TextStyle(fontSize: 15,)),
                                      if(snapshot.data!.data.candidate.exp.toString()=="1")
                                        Text("${snapshot.data!.data.candidate.exp.toString()} yr",
                                            style:
                                            TextStyle(fontSize: 15,)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Location : ",
                                          style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      Text("${snapshot.data!.data.candidate.loc.toString()}",
                                          style:
                                          TextStyle(fontSize: 15,)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Notice : ",
                                          style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      if(snapshot.data!.data.candidate.notice.toString()!="0")
                                      Text("${snapshot.data!.data.candidate.notice.toString()} days",
                                          style:
                                          TextStyle(fontSize: 15,)),
                                      if(snapshot.data!.data.candidate.notice.toString()=="0")
                                        Text("Immediate",
                                            style:
                                            TextStyle(fontSize: 18,)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Phone : ",
                                          style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      FutureBuilder(
                                          future: statmob(snapshot.data!.data.candidate.userId.toString()),
                                          builder: (context,AsyncSnapshot<Mobileview> snapshot2) {
                                            print(snapshot2.data);
                                            if (snapshot2.hasData) {
                                              if (snapshot2.data!.data.status.toString() == "true") {

                                                    candidate_phone = snapshot.data!.data.candidate.mobile.toString();
                                                    M_o_eye = true;
                                                    M_c_eye = false;


                                              }
                                                return Row(
                                                  children: [
                                                    Text(
                                                        "${candidate_phone}   ",
                                                        style:
                                                        TextStyle(
                                                          fontSize: 15,)),
                                                    Visibility(
                                                      visible: M_c_eye,
                                                      child: GestureDetector(
                                                          onTap: () async {
                                                            Mobileview b= await viewmob(snapshot.data!.data.candidate.userId.toString());
                                                            if(mob==200)
                                                              {
                                                                setState(() {
                                                                  candidate_phone = b.data.mobile.toString();
                                                                  M_o_eye = true;
                                                                  M_c_eye = false;
                                                                });

                                                              }


                                                          },
                                                          child: Icon(Icons
                                                              .remove_red_eye,
                                                            size: 15,)),
                                                    ),
                                                  ],
                                                );
                                              }
                                              else
                                                return Container();

                                          }
                                      )


                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Email : ",
                                          style:
                                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      FutureBuilder(
                                          future: statemail(snapshot.data!.data.candidate.userId.toString()),
                                          builder: (context,AsyncSnapshot<Mobileview> snapshot2) {
                                            print(snapshot2.data);
                                            if (snapshot2.hasData) {
                                              if (snapshot2.data!.data.status.toString() == "true") {

                                                  candidate_email = snapshot.data!.data.candidate.email.toString();
                                                  eml_o_eye=true;
                                                  eml_c_eye=false;


                                              }
                                              return Row(
                                                children: [
                                                  Text("${candidate_email}   ",
                                                      style:
                                                      TextStyle(fontSize: 15,)),
                                                  Visibility(
                                                    visible: eml_c_eye,
                                                    child: GestureDetector(
                                                        onTap: () async {
                                                          Mobileview B= await viewemail(snapshot.data!.data.candidate.userId.toString());
                                                          if(emailc==200){
                                                            setState(() {
                                                              candidate_email=B.data.email.toString();
                                                              eml_o_eye=true;
                                                              eml_c_eye=false;
                                                            });
                                                          }
                                                        },
                                                        child: Icon(Icons.remove_red_eye,size: 15,)),
                                                  ),
                                                ],
                                              );
                                            }
                                            else
                                              return Container();

                                          }
                                      )


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
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                                                fontSize: 14,
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
                                  Center(
                                    child: ToggleButtons(
                                      children: <Widget>[
                                        Text("  Psychometric  ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Candara",
                                            )),
                                        Text("  Int Score  ",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Candara",
                                            )),
                                        Text("      Reviews     ",
                                            style: TextStyle(
                                              fontSize: 16,
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
                                  SizedBox(height: 20),
                                  if(snapshot.data!.data.psychometricsResult.toString()!="null")
                                    Visibility(
                                    visible: psyc_vis,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Personality & Ability Performance",
                                          style: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                            "Personality has significant role to play to deciding whether "
                                                "you have the enthusiasm and motivation that the employer is "
                                                "looking for add and whether you are going to fit into the organization "
                                                "in term of personality,attitude and general work style.",
                                            style: TextStyle(
                                              fontFamily: "Candara",
                                              fontSize: 15,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        if(snapshot.data!.data.psychometricsResult.toString()!="No Information available")
                                        Text(
                                            "${snapshot.data!.data.psychometricsResult.name}"
                                          ,style: TextStyle(
                                              fontFamily: "Candara",
                                              fontSize: 15,
                                            )),
                                        Html(

                                          data: snapshot.data!.data.psychometricsResult.summary,

                                        ),


                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Description"
                                            ,style: TextStyle(
                                          fontFamily: "Candara",
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        )),
                                        Html(
                                          data: snapshot.data!.data.psychometricsResult.description.toString(),
                                        ),


                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            "Strengths"
                                            ,style: TextStyle(
                                            fontFamily: "Candara",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        )),
                                        Html(
                                          data:snapshot.data!.data.psychometricsResult.strengths.toString() ,
                                        ),

                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            "Weakness"
                                            ,style: TextStyle(
                                            fontFamily: "Candara",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        )),
                                        Html(
                                          data:snapshot.data!.data.psychometricsResult.weakness.toString() ,
                                        ),

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
                                                  fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${double.parse(snapshot.data!.data.candidate.ratings.toString())*4}%",
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),

                                        //Conceptual
                                        for(var i=0;i<snapshot.data!.data.feedback.length-1;i++)
                                          Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${snapshot.data!.data.feedback[i].heading.toString().toUpperCase()
                                                    } ",
                                                    style: TextStyle(fontSize: 15),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(8),
                                                    child: RatingBarIndicator(
                                                      rating: double.parse("${snapshot.data!.data.feedback[i].rating.toString()}"),
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
                                                height: 2,
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
                                                                "${snapshot.data!.data.feedback[i].text.toString()}",
                                                                style: TextStyle(
                                                                  fontFamily: "Candara",
                                                                  fontSize: 14,
                                                                )),
                                                          ),
                                                        ],
                                                      ))),
                                              SizedBox(height: 20,)

                                            ],
                                          ),
                                        ),

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
                    "${_name}",
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Dashboard()));
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

//shortlist interview
enum ConfirmAction4 { Reject, Invite }
Future<Future<ConfirmAction4?>> _asyncConfirmDialog4(
    BuildContext context, String id,String name) async {

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
                          " Shortlist Candidate",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Do you want to \nshortlist ${name}?",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
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
                      Icon(Icons.check_circle_outline,color: Colors.white,size: 20,),
                      Text(
                        ' Okay',
                        style: TextStyle(
                          fontFamily: 'Candara',
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    Shortlist B= await shortlistapi(id);
                    if(shortlist_code==200){
                      Navigator.pop(context);
                      showDialog(
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
                                        "${name}\nis moved to\nthe Shortlist stage",
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
                                        'Okay',
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
                      final Future<ConfirmAction5?> action =
                      await _asyncConfirmDialog5(context, "",name);

                    }

                  },
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 59, 48, 214))),
                  child: Row(
                    children: [
                      Icon(Icons.radio_button_unchecked,color: Colors.white,size: 20,),
                      Text(
                        ' Cancel',
                        style: TextStyle(
                          fontFamily: 'Candara',
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
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

//moved to shortlist popup
enum ConfirmAction5 { Reject, Invite }
Future<Future<ConfirmAction5?>> _asyncConfirmDialog5(
    BuildContext context, String id,String name) async {
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
                    "${name}\nis moved to\nthe Shortlist stage",
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
                    'Okay',
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

//schedule interview
late DateTime _selectedDate;
TextEditingController dateController = TextEditingController();
TextEditingController timeController = TextEditingController();
TextEditingController intnameController = TextEditingController();
TextEditingController intmailController = TextEditingController();
TextEditingController meetlink = TextEditingController();
TextEditingController phonelink = TextEditingController();
TextEditingController comments = TextEditingController();
TextEditingController remarks = TextEditingController();
TextEditingController reasons = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
TextEditingController ctcoffered = TextEditingController();
TextEditingController jobprof = TextEditingController();
TextEditingController joindate = TextEditingController();




//moved to interview popup
enum ConfirmAction7 { Reject, Invite }
Future<Future<ConfirmAction7?>> _asyncConfirmDialog7(
    BuildContext context, String id) async {
  return showDialog<ConfirmAction7>(
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
                    "${_name}\nis moved \nto the next stage",
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
                    'OKAY',
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
    firstDate: DateTime.now(),
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



