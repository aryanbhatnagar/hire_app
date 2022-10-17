import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hire_app/Candidate.dart';
import 'package:hire_app/CategoryList.dart';
import 'package:hire_app/Login.dart';
import 'package:hire_app/SeeAll.dart';
import 'package:hire_app/video.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'globals.dart';


Future<void> _logout() async {
  /*final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('role');
  prefs.remove('token');*/
  SharedPreferences.getInstance().then(
        (prefs) {
      prefs.remove("token");

    },
  );

}

Dashboard1 dashboard1FromJson(String str) => Dashboard1.fromJson(json.decode(str));
String dashboard1ToJson(Dashboard1 data) => json.encode(data.toJson());

class Dashboard1 {
  Dashboard1({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Dashboard1Data data;
  String message;

  factory Dashboard1.fromJson(Map<String, dynamic> json) => Dashboard1(
    success: json["success"],
    data: Dashboard1Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}
class Dashboard1Data {
  Dashboard1Data({
    required this.data,
  });

  DataData data;

  factory Dashboard1Data.fromJson(Map<String, dynamic> json) => Dashboard1Data(
    data: DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}
class DataData {
  DataData({
    required this.technologies,
    required this.category,
    required this.testimonials,
    required this.candidateTestimonial,
    required this.topRateProfiles,
    required this.quickJoiners,
    required this.fullProfiles,
    required this.shortListCandidates,
    required this.intetviewListCandidates,
    required this.selectedListCandidates,
    required this.stages,
    required this.user,
  });

  List<Technology> technologies;
  List<CategoryElement> category;
  List<Testimonial> testimonials;
  List<Testimonial> candidateTestimonial;
  List<FullProfile> topRateProfiles;
  List<FullProfile> quickJoiners;
  List<FullProfile> fullProfiles;
  List<FullProfile> shortListCandidates;
  List<FullProfile> intetviewListCandidates;
  List<FullProfile> selectedListCandidates;
  User user;
  List<Stage> stages;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    technologies: List<Technology>.from(json["technologies"].map((x) => Technology.fromJson(x))),
    category: List<CategoryElement>.from(json["category"].map((x) => CategoryElement.fromJson(x))),
    testimonials: List<Testimonial>.from(json["testimonials"].map((x) => Testimonial.fromJson(x))),
    candidateTestimonial: List<Testimonial>.from(json["candidate_testimonial"].map((x) => Testimonial.fromJson(x))),
    topRateProfiles: List<FullProfile>.from(json["top_rate_profiles"].map((x) => FullProfile.fromJson(x))),
    quickJoiners: List<FullProfile>.from(json["quick_joiners"].map((x) => FullProfile.fromJson(x))),
    fullProfiles: List<FullProfile>.from(json["full_profiles"].map((x) => FullProfile.fromJson(x))),
    shortListCandidates: List<FullProfile>.from(json["short_list_candidates"].map((x) => FullProfile.fromJson(x))),
    intetviewListCandidates: List<FullProfile>.from(json["intetview_list_candidates"].map((x) => FullProfile.fromJson(x))),
    selectedListCandidates: List<FullProfile>.from(json["selected_list_candidates"].map((x) => FullProfile.fromJson(x))),
    stages: List<Stage>.from(json["stages"].map((x) => Stage.fromJson(x))),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "technologies": List<dynamic>.from(technologies.map((x) => x.toJson())),
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "testimonials": List<dynamic>.from(testimonials.map((x) => x.toJson())),
    "candidate_testimonial": List<dynamic>.from(candidateTestimonial.map((x) => x.toJson())),
    "top_rate_profiles": List<dynamic>.from(topRateProfiles.map((x) => x.toJson())),
    "quick_joiners": List<dynamic>.from(quickJoiners.map((x) => x.toJson())),
    "full_profiles": List<dynamic>.from(fullProfiles.map((x) => x.toJson())),
    "short_list_candidates": List<dynamic>.from(shortListCandidates.map((x) => x.toJson())),
    "intetview_list_candidates": List<dynamic>.from(intetviewListCandidates.map((x) => x.toJson())),
    "selected_list_candidates": List<dynamic>.from(selectedListCandidates.map((x) => x.toJson())),
    "stages": List<dynamic>.from(stages.map((x) => x.toJson())),
    "user": user.toJson(),
  };
}
class Testimonial {
  Testimonial({
    this.id,
    this.name,
    this.designation,
    this.company,
    this.videoPath,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.message,
    this.img,
  });

  var id;
  var name;
  var designation;
  var company;
  dynamic videoPath;
  var status;
  dynamic createdAt;
  var updatedAt;
  var message;
  var img;

  factory Testimonial.fromJson(Map<String, dynamic> json) => Testimonial(
    id: json["id"],
    name: json["name"],
    designation: json["designation"],
    company: json["company"],
    videoPath: json["video_path"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    message: json["message"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "designation": designation,
    "company": company,
    "video_path": videoPath,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "message": message,
    "img":img
  };
}
class CategoryElement {
  CategoryElement({
    this.techType,
  });

  var techType;

  factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
    techType: json["tech_type"],
  );

  Map<String, dynamic> toJson() => {
    "tech_type": techType,
  };
}
class FullProfile {
  FullProfile({
    this.id,
    this.techId,
    this.tech,
    this.stageId,
    this.stage,
    this.name,
    this.profileImage,
    this.designation,
    this.exp,
    this.ctc,
    this.position,
    this.notice,
    this.email,
    this.mobile,
    this.psychoAna,
    this.socialAna,
    this.resumePath,
    this.resumeUpdate,
    this.imgPath,
    this.status,
    this.linkedin,
    this.github,
    this.facebook,
    this.twitter,
    this.intVideo,
    this.intAudio,
    this.insta,
    this.mailStatus,
    this.intStatus,
    this.createdOn,
    this.createdBy,
    this.ratings,
    this.company,
    this.loc,
    this.compWishlist,
    this.compInterview,
    this.skill,
    this.videoUplDt,
    this.videoUploadedBy,
    this.expectedCtc,
    this.highestQualification,
    this.assessmentLevel,
    this.timeSlot1,
    this.timeSlot2,
    this.dob,
    this.permanentAddress,
    this.maritalStatus,
    this.homeTown,
    this.gender,
    this.overview,
    this.pin,
    this.working_mode,
    this.category,
    this.assignTo,
    this.meetingLink,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  dynamic techId;
  var tech;
  var stageId;
  var stage;
  var name;
  var profileImage;
  var designation;
  var exp;
  var ctc;
  var position;
  var notice;
  var email;
  var mobile;
  dynamic psychoAna;
  dynamic socialAna;
  var resumePath;
  var resumeUpdate;
  var working_mode;
  dynamic imgPath;
  var status;
  var linkedin;
  var github;
  dynamic facebook;
  dynamic twitter;
  dynamic intVideo;
  dynamic intAudio;
  dynamic insta;
  var mailStatus;
  var intStatus;
  var createdOn;
  var createdBy;
  var ratings;
  var company;
  var loc;
  dynamic compWishlist;
  dynamic compInterview;
  var skill;
  dynamic videoUplDt;
  dynamic videoUploadedBy;
  var expectedCtc;
  var highestQualification;
  dynamic assessmentLevel;
  var timeSlot1;
  var timeSlot2;
  var dob;
  var permanentAddress;
  var maritalStatus;
  var homeTown;
  var gender;
  var overview;
  var pin;
  var category;
  var assignTo;
  var meetingLink;
  var userId;
  var createdAt;
  var updatedAt;

  factory FullProfile.fromJson(Map<String, dynamic> json) => FullProfile(
    id: json["id"],
    techId: json["tech_id"],
    tech: json["tech"],
    stageId: json["stage_id"],
    stage: json["stage"],
    name: json["name"],
    profileImage: json["profile_image"],
    designation: json["designation"],
    exp: json["exp"],
    ctc: json["ctc"],
    working_mode: json["working_mode"],
    position: json["position"],
    notice: json["notice"],
    email: json["email"],
    mobile: json["mobile"],
    psychoAna: json["psycho_ana"],
    socialAna: json["social_ana"],
    resumePath: json["resume_path"],
    resumeUpdate: json["resume_update"],
    imgPath: json["img_path"],
    status: json["status"],
    linkedin: json["linkedin"],
    github: json["github"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    intVideo: json["int_video"],
    intAudio: json["int_audio"],
    insta: json["insta"],
    mailStatus: json["mail_status"],
    intStatus: json["int_status"],
    createdOn: json["created_on"],
    createdBy: json["created_by"],
    ratings: json["ratings"],
    company: json["company"],
    loc: json["loc"],
    compWishlist: json["comp_wishlist"],
    compInterview: json["comp_interview"],
    skill:  json["skill"],
    videoUplDt: json["video_upl_dt"],
    videoUploadedBy: json["video_uploaded_by"],
    expectedCtc: json["expected_ctc"],
    highestQualification: json["highest_qualification"],
    assessmentLevel: json["assessment_level"],
    timeSlot1: json["time_slot_1"],
    timeSlot2: json["time_slot_2"],
    dob: json["dob"],
    permanentAddress: json["permanent_address"],
    maritalStatus: json["marital_status"],
    homeTown: json["home_town"],
    gender: json["gender"],
    overview: json["overview"],
    pin:  json["pin"],
    category: json["category"],
    assignTo: json["assign_to"],
    meetingLink: json["meeting_link"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tech_id": techId,
    "tech": tech,
    "stage_id": stageId,
    "stage": stage,
    "name": name,
    "profile_image": profileImage,
    "designation": designation,
    "exp": exp,
    "ctc": ctc,
    "position": position,
    "notice": notice,
    "email": email,
    "mobile": mobile,
    "psycho_ana": psychoAna,
    "social_ana": socialAna,
    "resume_path": resumePath,
    "resume_update": resumeUpdate,
    "img_path": imgPath,
    "working_mode":working_mode,
    "status": status,
    "linkedin": linkedin,
    "github": github,
    "facebook": facebook,
    "twitter": twitter,
    "int_video": intVideo,
    "int_audio": intAudio,
    "insta": insta,
    "mail_status":mailStatus,
    "int_status": intStatus,
    "created_on": createdOn ,
    "created_by": createdBy ,
    "ratings": ratings ,
    "company": company,
    "loc": loc,
    "comp_wishlist": compWishlist,
    "comp_interview": compInterview,
    "skill": skill ,
    "video_upl_dt": videoUplDt,
    "video_uploaded_by": videoUploadedBy,
    "expected_ctc": expectedCtc,
    "highest_qualification": highestQualification,
    "assessment_level": assessmentLevel,
    "time_slot_1": timeSlot1,
    "time_slot_2": timeSlot2,
    "dob": dob ,
    "permanent_address": permanentAddress ,
    "marital_status": maritalStatus ,
    "home_town": homeTown ,
    "gender": gender ,
    "overview": overview ,
    "pin": pin ,
    "category": category ,
    "assign_to": assignTo,
    "meeting_link": meetingLink ,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt
  };
}
class Technology {
  Technology({
    this.id,
    this.techName,
    this.techType,
    this.img,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var techName;
  var techType;
  var img;
  var status;
  var createdAt;
  var updatedAt;

  factory Technology.fromJson(Map<String, dynamic> json) => Technology(
    id: json["id"],
    techName: json["tech_name"],
    techType: json["tech_type"],
    img: json["img"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tech_name": techName,
    "tech_type": techType,
    "img": img,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
class User {
  User({
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.emailToken,
    this.verified,
    this.role,
    this.isEmployer,
    this.isStaffing,
    this.location,
    this.strength,
    this.address,
    this.logo,
    this.websiteUrl,
    this.emailVerifiedAt,
    this.terms,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var name;
  dynamic mobile;
  var email;
  var emailToken;
  var verified;
  var role;
  var isEmployer;
  var isStaffing;
  var location;
  var strength;
  dynamic address;
  dynamic logo;
  dynamic websiteUrl;
  dynamic emailVerifiedAt;
  var terms;
  var status;
  var createdAt;
  var updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    emailToken: json["email_token"],
    verified: json["verified"],
    role: json["role"],
    isEmployer: json["is_employer"],
    isStaffing: json["is_staffing"],
    location: json["location"],
    strength: json["strength"],
    address: json["address"],
    logo: json["logo"],
    websiteUrl: json["website_url"],
    emailVerifiedAt: json["email_verified_at"],
    terms: json["terms"],
    status: json["status"],
    createdAt:json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "email_token": emailToken,
    "verified": verified,
    "role": role,
    "is_employer": isEmployer,
    "is_staffing": isStaffing,
    "location": location,
    "strength": strength,
    "address": address,
    "logo": logo,
    "website_url": websiteUrl,
    "email_verified_at": emailVerifiedAt,
    "terms": terms,
    "status": status,
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

Plan planFromJson(String str) => Plan.fromJson(json.decode(str));
String planToJson(Plan data) => json.encode(data.toJson());

class Plan {
  Plan({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
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
    required this.plan,
  });

  PlanClass plan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    plan: PlanClass.fromJson(json["plan"]),
  );

  Map<String, dynamic> toJson() => {
    "plan": plan.toJson(),
  };
}
class PlanClass {
  PlanClass({
    this.userId,
    this.name,
    this.planName,
    this.validFrom,
    this.validTo,
    this.accessResume,
    this.accessVideo,
    this.accessemail,
    this.accessphone
  });

  var userId;
  var name;
  var planName;
  var validFrom;
  var validTo;
  var accessResume;
  var accessVideo;
  var accessphone;
  var accessemail;

  factory PlanClass.fromJson(Map<String, dynamic> json) => PlanClass(
    userId: json["user_id"],
    name: json["name"],
    planName: json["plan_name"],
    validFrom: json["valid_from"],
    validTo: json["valid_to"],
    accessResume: json["access_resume"],
    accessVideo: json["access_video"],
    accessemail: json["access_email"],
    accessphone: json["access_mobile"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "plan_name": planName,
    "valid_from": validFrom,
    "valid_to": validTo,
    "access_resume": accessResume,
    "access_video": accessVideo,
    "access_mobile":accessphone,
    "access_email":accessemail,
  };
}



Future<Dashboard1> getDashboardApi() async {
  final String apiUrl =
      "${BASE}api/dashboard";
  final response = await http.get(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  });

  if (response.statusCode == 200) {
    print("dashboard fetched");
    final String responseString = response.body;
    debugPrint(response.body);
    return dashboard1FromJson(responseString);
  }
  else {
    throw Exception('Failed to load album');
  }
}
Future<Plan> getPlanApi() async {
  final String apiUrl =
      "${BASE}api/employer/plan";
  final response = await http.get(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  });

  if (response.statusCode == 200) {
    print("plan fetched");
    final String responseString = response.body;
    debugPrint(response.body);
    return planFromJson(responseString);
  }
  else {
    throw Exception('Failed to load album');
  }
}


String _dropDownValue = "";
int c=0,d=0;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<bool> isSelected =[];
  List<bool> isSelected1 =List.generate(3, (index) => false);
  int _selectedIndex = 0;
  int topR=1;
  int quickj=0;
  int fullS=0;
  String tech="backend";

  List<String> _thumbnailUrl=[];


  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }

  Future<File> copyAssetFile(String assetFileName) async {
    Directory tempDir = await getTemporaryDirectory();
    final byteData = await rootBundle.load(assetFileName);

    File videoThumbnailFile = File("${tempDir.path}/$assetFileName")
      ..createSync(recursive: true)
      ..writeAsBytesSync(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return videoThumbnailFile;
  }

  void generateThumbnail(String url,int index) async {


    _thumbnailUrl[index] = (await VideoThumbnail.thumbnailFile(
      video:
      "${url}",
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,

    ))!;
    setState(() {});
  }


  String month(String m)
  {
    if(m=="01")
      return "Jan";
    if(m=="02")
      return "Feb";
    if(m=="03")
      return "Mar";
    if(m=="04")
      return "Apr";
    if(m=="05")
      return "May";
    if(m=="06")
      return "Jun";
    if(m=="07")
      return "Jul";
    if(m=="08")
      return "Aug";
    if(m=="09")
      return "Sep";
    if(m=="10")
      return "Oct";
    if(m=="11")
      return "Nov";
    else
      return "Dec";

  }



  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;

    List<Widget> _widgetOptions = <Widget>[
      FutureBuilder(
          future: getDashboardApi(),
          builder: (context,AsyncSnapshot<Dashboard1> snapshot) {
            print(snapshot.data);
            if (snapshot.hasData)
            {
              List<bool> isSelected =List.generate(snapshot.data!.data.data.category.length, (index) => false);
              isSelected[c]=true;
              tech=snapshot.data!.data.data.category[c].techType.toString();
              isSelected1[d]=true;
              return Container(
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


                            //welcome
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(width: size.width-220,image: AssetImage("images/kobl.png"))
                              ],
                            ),
                            SizedBox(height: 20,),

                            Row(
                              children: [
                                Text(
                                  "Welcome",
                                  style: TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                                for(var i=0;i<snapshot.data!.data.data.user.name.toString().split(" ")[0].split("").length;i++)
                                Row(
                                  children: [
                                    if(i==0)
                                      Text(
                                      " ${snapshot.data!.data.data.user.name.toString().split(" ")[0].split("")[i].toUpperCase()}",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[800]),
                                    ),
                                    if(i!=0)
                                      Text(
                                        "${snapshot.data!.data.data.user.name.toString().split(" ")[0].split("")[i]}",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[800]),
                                      ),

                                  ],
                                ),
                                Text(
                                  " !",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            //expandable containers
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.blue,
                                        Colors.lightBlueAccent,
                                        Colors.white70,

                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: ExpansionTile(
                                    expandedCrossAxisAlignment: CrossAxisAlignment.center,
                                    collapsedTextColor: Colors.black,
                                    textColor: Colors.black,
                                    title: Text('My Dashboard  ',style: TextStyle(fontSize: 18),),
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10,right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                    context, MaterialPageRoute(
                                                    builder: (context) => seeall(1)));
                                              },
                                              child: Column(
                                                children: [
                                                  Text("Shortlisted",style: TextStyle(fontSize: 16,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
                                                  Text("${snapshot.data!.data.data.shortListCandidates.length.toString()}")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                    context, MaterialPageRoute(
                                                    builder: (context) => seeall(2)));
                                              },
                                              child: Column(
                                                children: [
                                                  Text("Interviews",style: TextStyle(fontSize: 16,color: Colors.blue[800],fontWeight: FontWeight.bold),),
                                                  Text("${snapshot.data!.data.data.intetviewListCandidates.length.toString()}")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                    context, MaterialPageRoute(
                                                    builder: (context) => seeall(3)));
                                              },
                                              child: Column(
                                                children: [
                                                  Text("Hired",style: TextStyle(fontSize: 16,color: Colors.lightGreenAccent,fontWeight: FontWeight.bold),),
                                                  Text("${snapshot.data!.data.data.selectedListCandidates.length.toString()}")
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            //Text("Technology Hiring",style: TextStyle(fontSize: 16),),
                                          ],
                                        ),
                                      ),
                                      /*Container(
                                        //height: 100,
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            GridView.count(
                                              shrinkWrap: true,
                                              childAspectRatio: 2.25,
                                              crossAxisSpacing:5,
                                              mainAxisSpacing: 5,
                                              crossAxisCount: 3,
                                              children: <Widget>[
                                                for(var i=0;i<4;i++)
                                                  GestureDetector(
                                                      onTap: () {
                                                      },
                                                      child: Card(
                                                        color: Colors.blue[800],
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
                            /*Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.lightGreen,
                                        Colors.lightGreenAccent,
                                        Colors.white70,

                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: ExpansionTile(
                                    title: Text('My Stats',style: TextStyle(fontSize: 18),),
                                    children: <Widget>[
                                      Text('hello'),
                                      Text('123'),
                                      Text('17111'),
                                    ],
                                  ),
                                ),
                              ),
                            ),*/
                            SizedBox(height: 20,),

                            //upcoming interviews
                            if(snapshot.data!.data.data.intetviewListCandidates.length>0)
                            Row(
                              children: [
                                Text(
                                  "Upcoming",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " Interviews",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800]),
                                ),
                              ],
                            ),
                            if(snapshot.data!.data.data.intetviewListCandidates.length>0)
                            SizedBox(height: 10,),
                            if(snapshot.data!.data.data.intetviewListCandidates.length>0)
                            GridView.count(
                              shrinkWrap: true,
                              primary: false,
                              padding: const EdgeInsets.all(2),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                              crossAxisCount: 2,

                              children: <Widget>[
                                for (var i = 0; i < snapshot.data!.data.data.intetviewListCandidates.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context) => Candidate(snapshot.data!.data.data.intetviewListCandidates[i].userId.toString())));


                                    },
                                    child: Container(
                                      width: size.width-130,
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(
                                                10))),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(height: 2.5),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                              child: Container(
                                                width: size.width-140,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(height: 8,),
                                                    Center(
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        backgroundImage: snapshot.data!.data.data.intetviewListCandidates[i].profileImage==null?
                                                        NetworkImage("http://kobl.ai/img/profile.png")
                                                            :             NetworkImage("${snapshot.data!.data.data.intetviewListCandidates[i].profileImage}"),
                                                        radius: 28,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8,),
                                                    Text(
                                                        "${snapshot.data!.data.data.intetviewListCandidates[i].name}",
                                                        overflow: TextOverflow.clip,
                                                        maxLines: 2,
                                                        style: TextStyle(fontSize: 16,
                                                            fontFamily: "Candara",
                                                            color: Colors.black)),
                                                    SizedBox(height: 5),
                                                    Text(
                                                        "${snapshot.data!.data.data.intetviewListCandidates[i].timeSlot1.toString().split(" ")[0].split("-")[2]} "
                                                            "${month(snapshot.data!.data.data.intetviewListCandidates[i].timeSlot1.toString().split(" ")[0].split("-")[1])}, "
                                                            "${snapshot.data!.data.data.intetviewListCandidates[i].timeSlot1.toString().split(" ")[0].split("-")[0]} "
                                                            "${snapshot.data!.data.data.intetviewListCandidates[i].timeSlot1.toString().split(" ")[1]}"
                                                        , style: TextStyle(fontSize:15,
                                                        fontFamily: "Candara",
                                                        color: Colors.red)),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      "${snapshot.data!.data.data.intetviewListCandidates[i].tech.toString().toUpperCase()}\n", style: TextStyle(fontSize:15,
                                                        fontFamily: "Candara",
                                                        color: Colors.blue[800]),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),

                                      ),
                                    ),
                                  )

                              ],
                            ),
                            if(snapshot.data!.data.data.intetviewListCandidates.length>0)
                            SizedBox(height: 20,),

                            //top catgories
                            Row(
                              children: [
                                Text(
                                  "Top",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " Categories",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800]),
                                ),
                              ],
                            ),
                            Text(
                              "Find candidates to hire, Pick any language/skill to search & view",
                              style: TextStyle(
                                  fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),
                            ),
                            SizedBox(height: 20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ToggleButtons(
                                    children: <Widget>[
                                      for(int j=0;j<snapshot.data!.data.data.category.length;j++)
                                        Text("   ${snapshot.data!.data.data.category[j].techType.toString().toUpperCase()}   ",style: TextStyle(fontFamily: "Candara",fontSize: 14),)
                                    ],

                                    selectedBorderColor: Colors.blue[800],

                                    selectedColor: Colors.white,
                                    borderColor: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    disabledColor: Colors.transparent,
                                    disabledBorderColor: Colors.transparent,
                                    focusColor: Colors.blue[800],
                                    fillColor: Colors.blue[800],
                                    onPressed: (int index) {
                                      setState(() {
                                        //c++;
                                        for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                          if (buttonIndex == index) {
                                            isSelected[buttonIndex] = true;
                                            c=index;
                                          } else {
                                            isSelected[buttonIndex] = false;
                                          }
                                          tech=snapshot.data!.data.data.category[index].techType.toString();
                                        }
                                      });
                                    },
                                    isSelected: isSelected,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            /*for(var i=0;i<snapshot.data!.data.data.technologies.length;i++)
                              if(tech==snapshot.data!.data.data.technologies[i].techType.toString())
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) => CatList()));
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Center(
                                              child: CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                backgroundImage: NetworkImage("${BASE}${snapshot.data!.data.data.technologies[i].img}"),
                                                radius: 25,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${snapshot.data!.data.data.technologies[i].techName.toString()}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Candara',
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(height: 3,),
                                                  Text(
                                                      '${snapshot.data!.data.data.technologies[i].techType.toString()}',
                                                      style: TextStyle(
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily: 'Candara',
                                                        color: Colors.green,
                                                        fontSize: 15 ,
                                                      ),
                                                      maxLines: 5,
                                                      overflow: TextOverflow.ellipsis),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Icon(Icons.arrow_forward_ios, color: Colors.black, size: 25)

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),*/
                            GridView.count(
                              shrinkWrap: true,
                              primary: false,
                              childAspectRatio: 0.8,
                              padding: const EdgeInsets.all(2),
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 3,

                              children: <Widget>[
                                for(var i=0;i<snapshot.data!.data.data.technologies.length;i++)
                                  if(tech==snapshot.data!.data.data.technologies[i].techType.toString())
                                    GestureDetector(
                                      onTap:() async {
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => CatList(snapshot.data!.data.data.technologies[i].techName.toString(),snapshot.data!.data.data.technologies[i].techType,snapshot.data!.data.data.technologies[i].img.toString())));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 10,),
                                              Image(image: NetworkImage("${BASE}${snapshot.data!.data.data.technologies[i].img}"),height: 50,width: 55,),
                                              /*CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.transparent,
                                                  backgroundImage:
                                                  NetworkImage('${BASE}${snapshot.data!.data.data.technologies[i].img}')),*/
                                              SizedBox(height: 10),
                                              Text(
                                                " ${snapshot.data!.data.data.technologies[i].techName}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: "Candara"),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "${snapshot.data!.data.data.technologies[i].techType}",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 13,
                                                    fontFamily: "Candara"),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),

                                    ),

                              ],
                            ),
                            SizedBox(height: 10,),


                            //Recently Hired
                            SizedBox(height: 10,),
                            if(snapshot.data!.data.data.selectedListCandidates.length>0)
                            Row(
                              children: [
                                Text(
                                  "Recently",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " Hired",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800]),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            if(snapshot.data!.data.data.selectedListCandidates.length>0)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  for(var i=0;i<snapshot.data!.data.data.selectedListCandidates.length;i++)
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => Candidate(snapshot.data!.data.data.selectedListCandidates[i].userId.toString())));
                                      },
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Center(
                                                        child: CircleAvatar(
                                                          backgroundColor: Colors.transparent,
                                                          backgroundImage: snapshot.data!.data.data.selectedListCandidates[i].profileImage==null?
                                                          NetworkImage("http://kobl.ai/img/profile.png")
                                                              :             NetworkImage("${snapshot.data!.data.data.selectedListCandidates[i].profileImage}"),
                                                          radius: 28,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      RatingBarIndicator(
                                                        rating: 2.75,
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

                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${snapshot.data!.data.data.selectedListCandidates[i].name}",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Candara',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  SizedBox(height:10),
                                                  Text(
                                                      '${snapshot.data!.data.data.selectedListCandidates[i].tech.toString().toUpperCase()}',
                                                      style: TextStyle(

                                                        fontFamily: 'Candara',
                                                        color: Colors.blue,
                                                        fontSize: 14,
                                                      ),
                                                      maxLines: 5,
                                                      overflow: TextOverflow.ellipsis),

                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("CTC : ${snapshot.data!.data.data.selectedListCandidates[i].ctc.toString()} LPA",style: TextStyle(fontFamily: "Candara",fontSize: 13,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                      if(snapshot.data!.data.data.selectedListCandidates[i].exp.toString()!="1")
                                                      Text("     Exp : ${snapshot.data!.data.data.selectedListCandidates[i].exp.toString()} yrs  ",style: TextStyle(fontFamily: "Candara",fontSize: 13),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                      if(snapshot.data!.data.data.selectedListCandidates[i].exp.toString()=="1")
                                                        Text("     Exp : ${snapshot.data!.data.data.selectedListCandidates[i].exp.toString()} yr  ",style: TextStyle(fontFamily: "Candara",fontSize: 13),overflow: TextOverflow.ellipsis,maxLines: 2),

                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            SizedBox(height: 15,),

                            //rated
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ToggleButtons(
                                    children: <Widget>[
                                      //for(int j=0;j<3;j++)
                                      Text(" Top Rated  ",style: TextStyle(fontFamily: "Candara",fontSize: 18),),
                                      Text(" Full Stack  ",style: TextStyle(fontFamily: "Candara",fontSize: 18),),
                                      Text(" Qucik Joiner  ",style: TextStyle(fontFamily: "Candara",fontSize: 18),)

                                    ],

                                    selectedBorderColor: Colors.blue[800],

                                    selectedColor: Colors.white,
                                    //borderColor: Colors.transparent,
                                    borderColor: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                    disabledColor: Colors.transparent,
                                    disabledBorderColor: Colors.transparent,
                                    focusColor: Colors.blue[800],
                                    fillColor: Colors.blue[800],
                                    onPressed: (int index) {
                                      setState(() {
                                        d++;
                                        for (int buttonIndex = 0; buttonIndex < isSelected1.length; buttonIndex++) {
                                          if (buttonIndex == index) {
                                            isSelected1[buttonIndex] = true;
                                            d=index;
                                          } else {
                                            isSelected1[buttonIndex] = false;
                                          }
                                          if(index==0)
                                          {
                                            setState(() {
                                              topR=1;
                                              quickj=0;
                                              fullS=0;
                                            });
                                          }
                                          if(index==1)
                                          {
                                            setState(() {
                                              topR=0;
                                              quickj=0;
                                              fullS=1;
                                            });
                                          }
                                          if(index==2)
                                          {
                                            setState(() {
                                              topR=0;
                                              quickj=1;
                                              fullS=0;
                                            });
                                          }
                                        }
                                      });
                                    },
                                    isSelected: isSelected1,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  if(topR==1)
                                    for(var i=0;i<snapshot.data!.data.data.topRateProfiles.length;i++)
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) => Candidate(snapshot.data!.data.data.topRateProfiles[i].userId.toString())));

                                        },
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            width: size.width-60,
                                            child: Row(

                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Center(
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        backgroundImage: snapshot.data!.data.data.topRateProfiles[i].profileImage==null?
                                                        NetworkImage("http://kobl.ai/img/profile.png")
                                                            :             NetworkImage("${snapshot.data!.data.data.topRateProfiles[i].profileImage}"),
                                                        radius: 28,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),
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
                                                  ],
                                                ),
                                                SizedBox(width: 20,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${snapshot.data!.data.data.topRateProfiles[i].name.toString()}",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Candara',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(height:10),
                                                    SizedBox(
                                                      width: size.width/2,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Skill : ',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis),
                                                          Text(
                                                              '${snapshot.data!.data.data.topRateProfiles[i].tech.toString().toUpperCase()}  ',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.blue,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        if(snapshot.data!.data.data.topRateProfiles[i].exp.toString()!="1")
                                                        Text("Exp : ${snapshot.data!.data.data.topRateProfiles[i].exp.toString()} yrs   ",
                                                            style: TextStyle(
                                                              fontFamily: "Candara",
                                                              fontSize: 14,
                                                              //fontWeight: FontWeight.bold
                                                            ),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                        if(snapshot.data!.data.data.topRateProfiles[i].exp.toString()=="1")
                                                          Text("Exp : ${snapshot.data!.data.data.topRateProfiles[i].exp.toString()} yr   ",
                                                              style: TextStyle(
                                                                fontFamily: "Candara",
                                                                fontSize: 14,
                                                                //fontWeight: FontWeight.bold
                                                              ),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                        Text(
                                                            'Notice : ',
                                                            style: TextStyle(
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis),
                                                        if(snapshot.data!.data.data.topRateProfiles[i].notice.toString()!="0")
                                                          Text(
                                                            '${snapshot.data!.data.data.topRateProfiles[i].notice.toString().toUpperCase()} days',
                                                            style: TextStyle(
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis),
                                                        if(snapshot.data!.data.data.topRateProfiles[i].notice.toString()=="0")
                                                          Text(
                                                              'Immediate',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis)
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                                Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.orangeAccent,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  if(quickj==1)
                                    for(var i=0;i<snapshot.data!.data.data.quickJoiners.length;i++)
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) => Candidate(snapshot.data!.data.data.quickJoiners[i].userId.toString())));

                                        },
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            width: size.width-60,
                                            child: Row(

                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Center(
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        backgroundImage: snapshot.data!.data.data.quickJoiners[i].profileImage==null?
                                                        NetworkImage("http://kobl.ai/img/profile.png")
                                                            :             NetworkImage("${snapshot.data!.data.data.quickJoiners[i].profileImage}"),
                                                        radius: 28,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),
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
                                                  ],
                                                ),
                                                SizedBox(width: 20,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${snapshot.data!.data.data.quickJoiners[i].name.toString()}",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Candara',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(height:10),
                                                    SizedBox(
                                                      width: size.width/2,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Skill : ',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis),
                                                          Text(
                                                              '${snapshot.data!.data.data.quickJoiners[i].tech.toString().toUpperCase()}  ',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.blue,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        if(snapshot.data!.data.data.quickJoiners[i].exp.toString()!="1")
                                                          Text("Exp : ${snapshot.data!.data.data.quickJoiners[i].exp.toString()} yrs   ",
                                                              style: TextStyle(
                                                                fontFamily: "Candara",
                                                                fontSize: 14,
                                                                //fontWeight: FontWeight.bold
                                                              ),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                        if(snapshot.data!.data.data.quickJoiners[i].exp.toString()=="1")
                                                          Text("Exp : ${snapshot.data!.data.data.quickJoiners[i].exp.toString()} yr   ",
                                                              style: TextStyle(
                                                                fontFamily: "Candara",
                                                                fontSize: 14,
                                                                //fontWeight: FontWeight.bold
                                                              ),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                        Text(
                                                            'Notice : ',
                                                            style: TextStyle(
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis),
                                                        if(snapshot.data!.data.data.quickJoiners[i].notice.toString()!="0")
                                                          Text(
                                                              '${snapshot.data!.data.data.quickJoiners[i].notice.toString().toUpperCase()} days',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis),
                                                        if(snapshot.data!.data.data.quickJoiners[i].notice.toString()=="0")
                                                          Text(
                                                              'Immediate',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis)
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                                Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.orangeAccent,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  if(fullS==1)
                                    for(var i=0;i<snapshot.data!.data.data.fullProfiles.length;i++)
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) => Candidate(snapshot.data!.data.data.fullProfiles[i].userId.toString())));

                                        },
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            width: size.width-60,
                                            child: Row(

                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Center(
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.transparent,
                                                        backgroundImage: snapshot.data!.data.data.fullProfiles[i].profileImage==null?
                                                        NetworkImage("http://kobl.ai/img/profile.png")
                                                            :             NetworkImage("${snapshot.data!.data.data.fullProfiles[i].profileImage}"),
                                                        radius: 28,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),
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
                                                  ],
                                                ),
                                                SizedBox(width: 20,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${snapshot.data!.data.data.fullProfiles[i].name.toString()}",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Candara',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(height:10),
                                                    SizedBox(
                                                      width: size.width/2,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Skill : ',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis),
                                                          Text(
                                                              '${snapshot.data!.data.data.fullProfiles[i].tech.toString().toUpperCase()}  ',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.blue,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        if(snapshot.data!.data.data.fullProfiles[i].exp.toString()!="1")
                                                          Text("Exp : ${snapshot.data!.data.data.fullProfiles[i].exp.toString()} yrs   ",
                                                              style: TextStyle(
                                                                fontFamily: "Candara",
                                                                fontSize: 14,
                                                                //fontWeight: FontWeight.bold
                                                              ),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                        if(snapshot.data!.data.data.fullProfiles[i].exp.toString()=="1")
                                                          Text("Exp : ${snapshot.data!.data.data.fullProfiles[i].exp.toString()} yr   ",
                                                              style: TextStyle(
                                                                fontFamily: "Candara",
                                                                fontSize: 14,
                                                                //fontWeight: FontWeight.bold
                                                              ),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                        Text(
                                                            'Notice : ',
                                                            style: TextStyle(
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily: 'Candara',
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis),
                                                        if(snapshot.data!.data.data.fullProfiles[i].notice.toString()!="0")
                                                          Text(
                                                              '${snapshot.data!.data.data.fullProfiles[i].notice.toString().toUpperCase()} days',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis),
                                                        if(snapshot.data!.data.data.fullProfiles[i].notice.toString()=="0")
                                                          Text(
                                                              'Immediate',
                                                              style: TextStyle(
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: 'Candara',
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                              ),
                                                              maxLines: 2,
                                                              overflow: TextOverflow.ellipsis)
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                                Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.orangeAccent,)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),



                            //testimonial
                            SizedBox(height: 25,),
                            Row(
                              children: [
                                Text(
                                  "Employer",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " Testimonial",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800]),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children:[
                                    for(var i=0;i<snapshot.data!.data.data.testimonials.length;i++)
                                      Row(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: GestureDetector(
                                                    onTap:(){
                                                      if(snapshot.data!.data.data.testimonials[i].videoPath.toString()!="null"){
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible: false, // user must tap button for close dialog!
                                                        builder: (BuildContext context) {
                                                          return  Container(

                                                            child: VideoPlayerApp("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"),

                                                          );
                                                        },
                                                      );}

                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(15),
                                                        color: Colors.orange,
                                                        image: DecorationImage(
                                                            image: AssetImage("images/pradi2.png"),
                                                            fit: BoxFit.fill
                                                        ),
                                                      ),
                                                      height: (size.width/2)-25,
                                                      width: (size.width/2)-20,
                                                      child: Stack(
                                                        children: [
                                                          if( snapshot.data!.data.data.testimonials[i].videoPath.toString() == "null")
                                                            Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(15),
                                                                color: Colors.orange,
                                                                image: DecorationImage(
                                                                    image: NetworkImage("${snapshot.data!.data.data.testimonials[i].img.toString()}"),
                                                                fit: BoxFit.fill
                                                            ),
                                                          )),
                                                          if( snapshot.data!.data.data.testimonials[i].videoPath.toString() != "null")
                                                            Builder(
                                                                builder: (BuildContext context){
                                                                  generateThumbnail(snapshot.data!.data.data.testimonials[i].videoPath.toString(), i);
                                                                  return Container(
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      color: Colors.orange,
                                                                      image: DecorationImage(
                                                                          image: NetworkImage("${snapshot.data!.data.data.testimonials[i].img.toString()}"),
                                                                          fit: BoxFit.fill
                                                                      ),
                                                                    ),
                                                                child: Image.file(File(_thumbnailUrl![i])),);}
                                                            ),

                                                          if( snapshot.data!.data.data.testimonials[i].videoPath.toString() != "null")
                                                            Center(child: Icon(Icons.play_circle_fill,size: 30,color:Colors.white),),
                                                      ]
                                                      )

                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: ((size.width/2)-15)/10,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.zero,bottomLeft: Radius.zero,topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                                                          color: Colors.orangeAccent,
                                                        ),
                                                        width: ((size.width/2)-20),
                                                        //height:((size.width/2)-15)/2 ,
                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                                            child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                //crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                children:[
                                                                  Text("${snapshot.data!.data.data.testimonials[i].name}",style: TextStyle(fontSize: 24,color: Colors.white),),
                                                                  SizedBox(height: 5,),
                                                                  //if(snapshot.data!.data.data.testimonials[i].videoPath.toString()!="null")
                                                                    Text("${snapshot.data!.data.data.testimonials[i].designation}, ${snapshot.data!.data.data.testimonials[i].company}",style: TextStyle(fontSize: 12,color: Colors.white),),
                                                                  //if(snapshot.data!.data.data.testimonials[i].videoPath.toString()=="null")
                                                                   // Text("${snapshot.data!.data.data.testimonials[i].message}, ${snapshot.data!.data.data.testimonials[i].company}",style: TextStyle(fontSize: 12,color: Colors.white),)


                                                                ]

                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,)
                                        ],
                                      ),

                                  ]
                              ),
                            ),

                            //candidate
                            SizedBox(height: 15,),
                            Row(
                              children: [
                                Text(
                                  "Candidate",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " Testimonial",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800]),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children:[
                                    for(var i=0;i<snapshot.data!.data.data.candidateTestimonial.length;i++)
                                      Row(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Colors.orange,
                                                      image: DecorationImage(
                                                          image: AssetImage("images/pradi2.png"),
                                                          fit: BoxFit.fill
                                                      ),
                                                    ),
                                                    height: (size.width/2)-25,
                                                    width: (size.width/2)-20,
                                                    child: Stack(
                                                      children: [
                                                        if(snapshot.data!.data.data.candidateTestimonial[i].videoPath.toString()=="null")
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              color: Colors.orange,
                                                              image: DecorationImage(
                                                                  image: NetworkImage(snapshot.data!.data.data.candidateTestimonial[i].img.toString()),
                                                                  fit: BoxFit.fill
                                                              ),
                                                            ),
                                                            height: (size.width/2)-25,
                                                            width: (size.width/2)-20,

                                                          ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: ((size.width/2)-15)/10,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(topLeft: Radius.zero,bottomLeft: Radius.zero,topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                                                          color: Colors.orangeAccent,
                                                        ),
                                                        width: ((size.width/2)-20),
                                                        //height:((size.width/2)-15)/2 ,
                                                        child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                                            child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                //crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                children:[
                                                                  Text("${snapshot.data!.data.data.candidateTestimonial[i].name}",style: TextStyle(fontSize: 24,color: Colors.white),),
                                                                  SizedBox(height: 5,),
                                                                  Text("${snapshot.data!.data.data.candidateTestimonial[i].designation}, ${snapshot.data!.data.data.testimonials[i].company}",style: TextStyle(fontSize: 15,color: Colors.white),)

                                                                ]

                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),



                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,)
                                        ],
                                      ),

                                  ]
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )




                          ],
                        ),
                      ),
                    ),
                  ));
            }
            else
              return Center(child: Container(child: CircularProgressIndicator(color: Colors.deepOrange,)));
          }
      ),
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              height: 100,
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Card(
                color: Colors.orange,
                shadowColor: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              height: 100,
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Card(
                color: Colors.orange,
                shadowColor: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              height: 100,
              padding: EdgeInsets.only(left: 30, right: 30, top: 10),
              child: Card(
                color: Colors.orange,
                shadowColor: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      FutureBuilder(
          future: getDashboardApi(),
          builder: (context,AsyncSnapshot<Dashboard1> snapshot) {
            print(snapshot.data);
            if (snapshot.hasData)
            {
              return Scaffold(
                backgroundColor: Colors.white,
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
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.purple.shade200,

                                  Colors.orange.shade200,
                                  Colors.purple.shade200,

                                ],
                              )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(height: 30,),
                                Image(
                                  image: snapshot.data!.data.data.user.logo.toString()==null?
                                  NetworkImage("http://kobl.ai/img/profile.png")
                                      :             NetworkImage("${snapshot.data!.data.data.user.logo}"),


                                ),
                                SizedBox(height: 15,),
                                Center(
                                  child: Text(
                                    " ${snapshot.data!.data.data.user.name.toString()}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FutureBuilder(
                          future: getPlanApi(),
                          builder: (context,AsyncSnapshot<Plan> snapshot1) {
                            print(snapshot1.data);
                            if (snapshot1.hasData)
                            {
                              return Container(
                                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                                height: (size.height) - (size.height) / 3,
                                width: (size.width),
                                decoration: BoxDecoration(
                                    color: Colors.white, borderRadius: BorderRadius.circular(34)),
                                child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15,),
                                        Card(
                                          elevation: 5,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              //mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [

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
                                                        "Employer subscription plan",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold),
                                                      ),

                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "${snapshot1.data!.data.plan.planName.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 28,
                                                            fontWeight: FontWeight.bold,
                                                          color: Colors.grey
                                                        ),
                                                      ),
                                                      SizedBox(height: 15,),
                                                      Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                " Video Access",
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.orangeAccent
                                                                ),
                                                              ),
                                                              Card(
                                                                color: Colors.blue.shade200,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 25.0,right: 25,top: 8,bottom: 8),
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
                                                                          "${snapshot1.data!.data.plan.accessVideo.toString()}",
                                                                          style: TextStyle(

                                                                            color: Colors.white,
                                                                            fontSize: 14,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                " Resume Access",
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.orangeAccent
                                                                ),
                                                              ),
                                                              Card(
                                                                color: Colors.blue.shade200,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 25.0,right: 25,top: 8,bottom: 8),
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
                                                                          "${snapshot1.data!.data.plan.accessResume.toString()}",
                                                                          style: TextStyle(

                                                                            color: Colors.white,
                                                                            fontSize: 14,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                      SizedBox(height: 15,),
                                                      Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                " Mobile Access",
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.orangeAccent
                                                                ),
                                                              ),
                                                              Card(
                                                                color: Colors.blue.shade200,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 25.0,right: 25,top: 8,bottom: 8),
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
                                                                          "${snapshot1.data!.data.plan.accessphone.toString()}",
                                                                          style: TextStyle(

                                                                            color: Colors.white,
                                                                            fontSize: 14,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                " Email Access",
                                                                style: TextStyle(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.orangeAccent
                                                                ),
                                                              ),
                                                              Card(
                                                                color: Colors.blue.shade200,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 25.0,right: 25,top: 8,bottom: 8),
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
                                                                          "${snapshot1.data!.data.plan.accessemail.toString()}",
                                                                          style: TextStyle(

                                                                            color: Colors.white,
                                                                            fontSize: 14,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),

                                                        ],
                                                      ),

                                                      SizedBox(height: 10,),
                                                      Text(
                                                        " Valid From - To : ",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.orangeAccent
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Card(
                                                            elevation: 0,
                                                            color: Colors.white,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
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
                                                                      "${snapshot1.data!.data.plan.validFrom}",
                                                                      style: TextStyle(

                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Text("-"),
                                                          Card(
                                                            elevation: 0,
                                                            color: Colors.white,
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
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
                                                                      "${snapshot1.data!.data.plan.validTo.toString()}",
                                                                      style: TextStyle(

                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
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

                                        SizedBox(height: 15,),
                                        Card(
                                          elevation: 5,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              //mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [

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
                                                        "Contact Details",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold),
                                                      ),


                                                      SizedBox(height: 10,),
                                                      Text(
                                                        "E-mail : ${snapshot.data!.data.data.user.email.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.orangeAccent
                                                        ),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Text(
                                                        "Website : ${snapshot.data!.data.data.user.websiteUrl.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.redAccent
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "Address: ",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.orangeAccent
                                                        ),
                                                      ),
                                                      Text(
                                                        "${snapshot.data!.data.data.user.address.toString()}",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.grey
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
                                      ],
                                    )),
                              );
                            }
                            else
                              return Center(child: Container(child: CircularProgressIndicator(color: Colors.deepOrange,)));
                          }
                      )
                    )
                  ],
                ),
              );
            }
            else
              return Center(child: Container(child: CircularProgressIndicator(color: Colors.deepOrange,)));
          }
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      drawerEdgeDragWidth: 50,
      drawer: Drawer(
          elevation: 5,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                ),
                child: Text('MENU'),
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () async {
                  setState(() {
                    token="";
                  });
                  await _logout();

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ],
          )),
      backgroundColor:Color.fromARGB(244,244, 239, 235),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white70,
          showUnselectedLabels: true,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 30),
                label: 'Home',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded, size: 30),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_sharp, size: 30),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 5),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
