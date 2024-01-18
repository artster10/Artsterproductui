import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productui/loading.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import 'editprofile.dart';
void main() {
  runApp(const UserProfile());
}

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserProfilePage(title: 'View Profile'),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key, required this.title});

  final String title;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  _UserProfilePageState() {
    _send_data();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(

        body:SingleChildScrollView(
          child: Stack(
            children: [

              Container(
                margin: EdgeInsets.fromLTRB(16.0, 140.0, 16.0, 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 110.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            ' $fname_',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          // Text(
                                          //   '$email',
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyText1,
                                          // ),
                                          SizedBox(
                                            height: 40,
                                          )
                                        ],
                                      ),

                                    ],
                                  )),

                            ],
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image:  DecorationImage(
                                  image: NetworkImage('$photo_'
                                      ),
                                  fit: BoxFit.cover)),
                          margin: EdgeInsets.only(left: 20.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children:  [
                          ListTile(
                            title: Text("Profile Information"),
                          ),
                          Divider(),
                          ListTile(
                            title: Text("Location"),
                            subtitle: Text('$sname_'),
                            leading: Icon(Icons.place),
                          ),



                          ListTile(
                            title: Text("Gender"),
                            subtitle: Text('$gender_'),
                            leading: Icon(Icons.male_sharp),
                          ),
                          ListTile(
                            title: Text('Email'),
                            subtitle: Text(email_),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text("Phone"),
                            subtitle: Text(phone_),
                            leading: Icon(Icons.phone),
                          ),


                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 60,
                left: 20,
                child: MaterialButton(
                  minWidth: 0.2,
                  elevation: 0.2,
                  color: Colors.white,
                  child: const Icon(Icons.arrow_back_ios_outlined,
                      color: Colors.indigo),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) =>Loading (),));



                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  String fname_ = "";
  String sname_ = "";
  String dob_ = "";
  String gender_ = "";
  String email_ = "";
  String phone_ = "";
  // String password_ = "";
  // String confirmpassword_ = "";
  String photo_ = "";

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String img_url = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/view_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String fname = jsonDecode(response.body)['fname'];
          String sname = jsonDecode(response.body)['sname'];
          String dob = jsonDecode(response.body)['dateofbirth'];
          String gender = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['mobno'];
          String photo = img_url + jsonDecode(response.body)['img'];

          setState(() {
            fname_ = fname;
            sname_ = sname;
            dob_ = dob;
            gender_ = gender;
            email_ = email;
            phone_ = phone;
            photo_ = photo;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
