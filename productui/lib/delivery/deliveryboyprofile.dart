import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';

// import 'editprofile.dart';
void main() {
  runApp(const deliveryViewProfile());
}

class deliveryViewProfile extends StatelessWidget {
  const deliveryViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const deliveryViewProfilePage(title: 'View Profile'),
    );
  }
}

class deliveryViewProfilePage extends StatefulWidget {
  const deliveryViewProfilePage({super.key, required this.title});

  final String title;

  @override
  State<deliveryViewProfilePage> createState() => _deliveryViewProfilePageState();
}

class _deliveryViewProfilePageState extends State<deliveryViewProfilePage> {
  _deliveryViewProfilePageState() {
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

                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('First name'),
                        Text(name_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Second name'),
                        Text(location_),
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

  String name_ = "";
  String location_ = "";
  String gender_ = "";
  String email_ = "";
  String phone_ = "";
  // String password_ = "";
  // String confirmpassword_ = "";

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    final urls = Uri.parse('$url/and_deliveryboy/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'];
          String location = jsonDecode(response.body)['location'];
          String gender = jsonDecode(response.body)['gender'];

          String email = jsonDecode(response.body)['email'];
          String phone = jsonDecode(response.body)['mobno'];

          setState(() {
            name_ = name;
            location_ = location;
            gender_ = gender;
            email_ = email;
            phone_ = phone;

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
