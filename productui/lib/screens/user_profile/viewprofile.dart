import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import 'editprofile.dart';
void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewProfilePage(title: 'View Profile'),
    );
  }
}

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  _ViewProfilePageState() {
    _send_data();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
              ),
              Column(
                children: [
                  Image(
                    image: NetworkImage(photo_),
                    height: 200,
                    width: 200,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('First name'),
                        Text(fname_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Second name'),
                        Text(sname_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Gender'),
                        Text(gender_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Dob'),
                        Text(dob_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('E-mail'),
                        Text(email_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phone'),
                        Text(phone_),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(password_),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.all(5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(confirmpassword_),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(
              //       builder: (context) => MyEditPage(title: "Edit Profile"),));
              //   },
              //   child: Text("Edit Profile"),
              // ),
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

    final urls = Uri.parse('$url/myapp/view_profile/');
    try {
      final response = await http.post(urls, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String fname = jsonDecode(response.body)['first name'];
          String sname = jsonDecode(response.body)['second name'];
          String dob = jsonDecode(response.body)['dob'];
          String gender = jsonDecode(response.body)['gender'];
          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['phone'];
          String photo = url + jsonDecode(response.body)['photo'];

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
