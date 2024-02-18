import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:productui/feedback.dart';
import 'package:productui/screens/profile/profile_screen.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat.dart';



void main() {
  runApp(const UserViewArtist());
}

class UserViewArtist extends StatelessWidget {
  const UserViewArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Trainer',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
            255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const UserViewArtistPage(title: 'View Mechanic'),
    );
  }
}

class UserViewArtistPage extends StatefulWidget {
  const UserViewArtistPage({super.key, required this.title});

  final String title;

  @override
  State<UserViewArtistPage> createState() => _UserViewArtistPageState();
}

class _UserViewArtistPageState extends State<UserViewArtistPage> {
  TextEditingController search = TextEditingController();
  late Future canChangeData = _search_data();


  _UserViewArtistPageState()
  {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> aid_ = <String>[];

  List<String> firstname_= <String>[];
  List<String> secondname_= <String>[];
  List<String> photo_= <String>[];
  List<String> email_= <String>[];
  List<String> phone_= <String>[];
  List<String> category_= <String>[];
  List<String> gender_= <String>[];
  List<String> dateofbirth_= <String>[];
  // List<String> place_= <String>[];
  // List<String> post_= <String>[];
  // List<String> pin_= <String>[];
  // List<String> state_= <String>[];
  // List<String> district_= <String>[];

  // List<String> qualification_= <String>[];
  // List<String> loginid_= <String>[];






  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> aid = <String>[];

    List<String> firstname = <String>[];
    List<String> secondname = <String>[];
    List<String> email = <String>[];
    List<String> phone = <String>[];
    List<String> category = <String>[];
    List<String> gender = <String>[];
    List<String> dateofbirth = <String>[];

    // List<String> gender= <String>[];
    //
    // List<String> place= <String>[];
    // List<String> post= <String>[];
    // List<String> pin= <String>[];
    // List<String> state= <String>[];
    // List<String> district= <String>[];
    List<String> photo= <String>[];
    // List<String> qualification= <String>[];
    // List<String> loginid= <String>[];




    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String did = sh.getString('did').toString();
      // String laid = sh.getString('laid').toString();
      String url = '$urls/and_viewartist/';

      var data = await http.post(Uri.parse(url), body: {
        "did":did,
        // "laid":laid,


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        aid.add(arr[i]['aid'].toString());

        // loginid.add(arr[i]['logid'].toString());

        firstname.add(arr[i]['fname']);
        secondname.add(arr[i]['lname']);
        email.add(arr[i]['email']);


        phone.add(arr[i]['phone']);
        category.add(arr[i]['category']);
        gender.add(arr[i]['gender']);
        dateofbirth.add(arr[i]['dateofbirth']);
        photo.add(sh.getString("img_url").toString()+arr[i]['img']);
      }

      setState(() {
        id_ = id;
        aid_ = aid;

        firstname_ = firstname;
       secondname_ = secondname;
        phone_=phone;
        email_ = email;
        photo_=photo;
        category_=category;
        gender_=gender;
        dateofbirth_=dateofbirth;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }
  Future<void> _search_data() async {
    List<String> id = <String>[];
    List<String> firstname = <String>[];
    List<String> secondname = <String>[];
    List<String> email = <String>[];
    List<String> phone = <String>[];
    List<String> category = <String>[];
    List<String> gender = <String>[];
    List<String> dateofbirth = <String>[];

    List<String> photo = <String>[];
    // List<String> proof = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      // String did = sh.getString('did').toString();
      // String laid = sh.getString('laid').toString();
      String names = search.text;
      String url = '$urls/search/';

      var data = await http.post(Uri.parse(url), body: {
        // "did": did,
        // "laid": laid,
        "name": names,


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());

        firstname.add(arr[i]['fname']);
        secondname.add(arr[i]['lname']);
        email.add(arr[i]['email']);


        phone.add(arr[i]['phone']);
        category.add(arr[i]['category']);
        gender.add(arr[i]['gender']);
        dateofbirth.add(arr[i]['dateofbirth']);

        photo.add(sh.getString("img_url").toString()+arr[i]['img']);

      }

      setState(() {
        id_ = id;
        firstname_ = firstname;
        secondname_ = secondname;
        phone_=phone;
        email_ = email;
        photo_=photo;
        category_=category;
        gender_=gender;
        dateofbirth_=dateofbirth;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }





  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.pink.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: TextField(
            controller: search,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                canChangeData = _search_data();
              });
              // Perform search functionality here
            },
          ),

          // leading: BackButton( onPressed:() {
          //
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => MyHomePage(title: 'home')),);
          //
          // },),
          // backgroundColor: Theme.of(context).colorScheme.primary,
          // title: Text(widget.title),
        ),

        body: Container(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            // padding: EdgeInsets.all(5.0),
            // shrinkWrap: true,
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onLongPress: () {
                  print("long press" + index.toString());
                },
                title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Card(
                          elevation: 8,
                          shadowColor: Colors.black,
                          color: Colors.black,
                          margin: EdgeInsets.all(10),

                          child:
                          GestureDetector(
                            onTap: () async {

                              SharedPreferences sh = await SharedPreferences.getInstance();
                              sh.setString("aid", id_[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ));
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width ,

                              child: Column(
                                children: [
                                  SizedBox(width: 50,),

                                  Padding(
                                    padding: EdgeInsets.all(5),

                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        // Text("Photo :",style: TextStyle(fontWeight: FontWeight.bold)),
                                        SizedBox(width: 50,),

                                        CircleAvatar(backgroundImage: NetworkImage(photo_[index]),
                                          radius:50,

                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Text(" Name    ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,)),
                                        SizedBox(width: 10,),
                                        Text(firstname_[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        )

                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Text(" Secondname ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,)),
                                        SizedBox(width: 10,),
                                        Text(secondname_[index],textAlign: TextAlign.center,
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.all(5),
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //
                                  //     children: [
                                  //       Text("secondname  ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,)),
                                  //       SizedBox(width: 10,),
                                  //       Text(secondname_[index],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),),
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Text(" phone",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,)),
                                        SizedBox(width: 10,),
                                        Text(phone_[index],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
                                        Text("Email  ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,)),
                                        SizedBox(width: 10,),
                                        Text(email_[index],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(onPressed: ()async{
                                    SharedPreferences sh = await SharedPreferences.getInstance();
                                    sh.setString("aid", aid_[index]);
                                    sh.setString("agrname", firstname_[index]);
                                    Navigator.push(context, MaterialPageRoute(

                                      builder: (context) => MyChatPage(title: '',),));
                                  }, child: Text('Chat')),



                                  // ElevatedButton(
                                  //   onPressed: () async {
                                  //
                                  //     SharedPreferences sh = await SharedPreferences.getInstance();
                                  //     String url = sh.getString('url').toString();
                                  //     String lid = sh.getString('lid').toString();
                                  //     // String sid = sh.getString('sid').toString();
                                  //     String tid = loginid_[index].toString();
                                  //
                                  //     final urls = Uri.parse('$url/user_send_request_mechanic/');
                                  //     try {
                                  //       final response = await http.post(urls, body: {
                                  //         'lid':lid,
                                  //         'tolid':tid,
                                  //         'type':'mechanic'
                                  //
                                  //
                                  //       });
                                  //       if (response.statusCode == 200) {
                                  //         String status = jsonDecode(response.body)['status'];
                                  //         if (status=='ok') {
                                  //           Fluttertoast.showToast(msg: 'Request Send Successfully');
                                  //
                                  //           Navigator.push(context, MaterialPageRoute(
                                  //
                                  //             builder: (context) => UserViewArtistPage(title: 'Trainer',),));
                                  //         }
                                  //         else {
                                  //           Fluttertoast.showToast(msg: 'Already Requested');
                                  //         }
                                  //       }
                                  //       else {
                                  //         Fluttertoast.showToast(msg: 'Network Error');
                                  //       }
                                  //     }
                                  //     catch (e){
                                  //       Fluttertoast.showToast(msg: e.toString());
                                  //     }
                                  //
                                  //
                                  //
                                  //
                                  //
                                  //
                                  //   },
                                  //   child: Text("Request"),
                                  // ),
                                  SizedBox(width: 10,),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}